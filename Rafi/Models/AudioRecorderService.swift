//
//  AudioRecorderService.swift
//  Rafi
//
//  Created by Noor Alhassani on 20/06/1447 AH.
//

import Foundation
import AVFoundation
import Combine

@MainActor
final class AudioRecorderService: ObservableObject {
    var objectWillChange: ObservableObjectPublisher = .init()

    @Published var isRecording: Bool = false
    @Published var elapsedTime: TimeInterval = 0
    @Published var meterLevel: Float = 0   // 0...1 (للـ waveform/voice memos)
    @Published var lastErrorMessage: String?

    private var recorder: AVAudioRecorder?
    private var timer: Timer?
    private var startDate: Date?

    // ملف التسجيل الحالي
    private(set) var currentFileURL: URL?

    // MARK: - Permissions
    func requestPermissionIfNeeded() async -> Bool {
        if #available(iOS 17.0, *) {
            // New API on iOS 17+
            switch AVAudioApplication.shared.recordPermission {
            case .granted:
                return true
            case .denied:
                lastErrorMessage = "Microphone permission denied. Enable it from Settings."
                return false
            case .undetermined:
                return await withCheckedContinuation { continuation in
                    AVAudioApplication.requestRecordPermission { granted in
                        Task { @MainActor in
                            if !granted {
                                self.lastErrorMessage = "Microphone permission denied."
                            }
                            continuation.resume(returning: granted)
                        }
                    }
                }
            @unknown default:
                return false
            }
        } else {
            // Fallback for iOS < 17
            let session = AVAudioSession.sharedInstance()
            switch session.recordPermission {
            case .granted:
                return true
            case .denied:
                lastErrorMessage = "Microphone permission denied. Enable it from Settings."
                return false
            case .undetermined:
                return await withCheckedContinuation { continuation in
                    session.requestRecordPermission { granted in
                        Task { @MainActor in
                            if !granted {
                                self.lastErrorMessage = "Microphone permission denied."
                            }
                            continuation.resume(returning: granted)
                        }
                    }
                }
            @unknown default:
                return false
            }
        }
    }

    // MARK: - Recording
    func startRecording() async {
        lastErrorMessage = nil

        let allowed = await requestPermissionIfNeeded()
        guard allowed else { return }

        do {
            try configureSession()

            let url = makeNewRecordingURL()
            currentFileURL = url

            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]

            let newRecorder = try AVAudioRecorder(url: url, settings: settings)
            newRecorder.isMeteringEnabled = true
            newRecorder.prepareToRecord()
            newRecorder.record()

            recorder = newRecorder
            isRecording = true

            startDate = Date()
            elapsedTime = 0
            startTimer()

        } catch {
            lastErrorMessage = "Could not start recording: \(error.localizedDescription)"
            stopTimer()
            isRecording = false
            recorder = nil
        }
    }

    func stopRecording() -> URL? {
        guard isRecording else { return currentFileURL }

        recorder?.stop()
        recorder = nil

        isRecording = false
        stopTimer()

        return currentFileURL
    }

    func cancelRecordingAndDeleteFile() {
        let urlToDelete = currentFileURL
        _ = stopRecording()
        currentFileURL = nil

        if let url = urlToDelete {
            try? FileManager.default.removeItem(at: url)
        }
    }

    // MARK: - Session
    private func configureSession() throws {
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
        try session.setActive(true, options: .notifyOthersOnDeactivation)
    }

    // MARK: - Timer + Meter
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            guard let self else { return }
            self.tick()
        }
        RunLoop.main.add(timer!, forMode: .common)
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        meterLevel = 0
        elapsedTime = 0
        startDate = nil
    }

    private func tick() {
        guard let recorder else { return }

        if let startDate {
            elapsedTime = Date().timeIntervalSince(startDate)
        }

        recorder.updateMeters()
        let power = recorder.averagePower(forChannel: 0) // -160...0
        meterLevel = normalizedPower(power)
    }

    private func normalizedPower(_ power: Float) -> Float {
        // تحويل -160..0 إلى 0..1 بشكل لطيف
        let minDb: Float = -60
        if power < minDb { return 0 }
        if power >= 0 { return 1 }
        return (power - minDb) / abs(minDb)
    }

    // MARK: - File URLs
    private func recordingsFolder() -> URL {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let folder = docs.appendingPathComponent("Recordings", isDirectory: true)
        if !FileManager.default.fileExists(atPath: folder.path) {
            try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        }
        return folder
    }

    private func makeNewRecordingURL() -> URL {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        let name = "rec_\(formatter.string(from: Date())).m4a"
        return recordingsFolder().appendingPathComponent(name)
    }
}
