//
//  JournalHistoryViewModel.swift
//  Rafi
//
//  Created by Noor Alhassani on 20/06/1447 AH.
//

import Foundation
import Combine

class JournalHistoryViewModel: ObservableObject {

    // MARK: - Published data for the View
    @Published var entries: [JournalEntry] = [
        JournalEntry(title: "Morning Thoughts", date: Date(), heartLevel: 1),
        JournalEntry(title: "Evening Reflection", date: Date().addingTimeInterval(-86400), heartLevel: 1),
        JournalEntry(title: "Weekend Plans", date: Date().addingTimeInterval(-172800), heartLevel: 3),
        JournalEntry(title: "Daily Goals", date: Date().addingTimeInterval(-259200), heartLevel: 2)
    ]

    @Published var isRecording: Bool = false

    // MARK: - Private service
    private let recorder = AudioRecorderService()

    // MARK: - Recording API for the View
    func toggleRecording() {
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
    }

    private func startRecording() {
        recorder.startRecording()
        isRecording = true      // rely on our own flag for UI
    }

    private func stopRecording() {
        recorder.stopRecording()
        isRecording = false
    }
}
