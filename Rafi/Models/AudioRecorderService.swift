//
//  AudioRecorderService.swift
//  Rafi
//
//  Created by Noor Alhassani on 20/06/1447 AH.
//

import Foundation
import AVFoundation

class AudioRecorderService {

    private var audioRecorder: AVAudioRecorder?
    private let session = AVAudioSession.sharedInstance()

    // Simple flag so ViewModel can know state
    private(set) var isRecording: Bool = false

    func startRecording() {
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)

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
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

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
            print("🎙 Started recording at:", url)
        } catch {
            print("❌ Could not start recording:", error)
        }
    }

    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        print("⏹ Stopped recording")
    }
}
