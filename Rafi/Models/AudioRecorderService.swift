//
//  AudioRecorderService.swift
//  Rafi
//
//  Created by Noor Alhassani on 20/06/1447 AH.
//

import Foundation
import AVFoundation
import AVFAudio

class AudioRecorderService {
    private var audioRecorder: AVAudioRecorder?
    private let session = AVAudioSession.sharedInstance()

    private(set) var isRecording = false
    private(set) var lastRecordingURL: URL?

    func startRecording() {
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)

            // Use new API on iOS 17+, fall back on older API otherwise
            if #available(iOS 17.0, *) {
                AVAudioApplication.requestRecordPermission { [weak self] allowed in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        if allowed {
                            self.beginRecording()
                        } else {
                            print("❌ Microphone permission denied")
                        }
                    }
                }
            } else {
                session.requestRecordPermission { [weak self] allowed in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        if allowed {
                            self.beginRecording()
                        } else {
                            print("❌ Microphone permission denied")
                        }
                    }
                }
            }
        } catch {
            print("❌ Failed to set up audio session:", error)
        }
    }

    private func beginRecording() {
        let fileName = "journal-\(Date().timeIntervalSince1970).m4a"

        let documents = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask).first!
        let url = documents.appendingPathComponent(fileName)

        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder?.record()
            isRecording = true
            lastRecordingURL = url
            print("🎙 Started recording at:", url)
        } catch {
            print("❌ Could not start recording:", error)
        }
    }

    /// Stop recording and return the file URL
    func stopRecording() -> URL? {
        audioRecorder?.stop()
        isRecording = false
        let url = lastRecordingURL
        print("⏹ Stopped recording at:", url?.absoluteString ?? "nil")
        return url
    }
}
