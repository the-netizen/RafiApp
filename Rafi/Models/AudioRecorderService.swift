//
//  AudioRecorderService.swift
//  Rafi
//
//  Created by Noor Alhassani on 20/06/1447 AH.
//

import Foundation
import AVFoundation
import Combine

final class AudioRecorderService: NSObject, ObservableObject {
    @Published private(set) var isRecording: Bool = false
    @Published private(set) var elapsed: TimeInterval = 0

    // Expose elapsed as currentTime for the view that expects it
    var currentTime: TimeInterval { elapsed }

    private var recorder: AVAudioRecorder?
    private var timer: Timer?
    private var startDate: Date?

    func requestPermission() async -> Bool {
        await withCheckedContinuation { cont in
            if #available(iOS 17.0, *) {
                AVAudioApplication.requestRecordPermission { allowed in
                    cont.resume(returning: allowed)
                }
            } else {
                AVAudioSession.sharedInstance().requestRecordPermission { allowed in
                    cont.resume(returning: allowed)
                }
            }
        }
    }

    // Convenience start that generates a file name and returns it (as used by JournalRecordingView)
    func startRecording() throws -> String {
        let name = Self.generateFileName()
        try startRecording(fileName: name)
        return name
    }

    func startRecording(fileName: String) throws {
        let session = AVAudioSession.sharedInstance()
        // Use option cases directly; prefer .allowBluetooth over deprecated .allowBluetoothHFP
        try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
        try session.setActive(true)

        let url = Self.fileURL(fileName: fileName)

        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        recorder = try AVAudioRecorder(url: url, settings: settings)
        recorder?.prepareToRecord()
        recorder?.record()

        startDate = Date()
        elapsed = 0
        isRecording = true

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] _ in
            guard let self, let startDate = self.startDate else { return }
            self.elapsed = Date().timeIntervalSince(startDate)
        }
    }

    func stopRecording() {
        recorder?.stop()
        recorder = nil
        timer?.invalidate()
        timer = nil
        isRecording = false
    }

    static func fileURL(fileName: String) -> URL {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return docs.appendingPathComponent(fileName)
    }

    static func generateFileName() -> String {
        "journal_\(UUID().uuidString).m4a"
    }
}
