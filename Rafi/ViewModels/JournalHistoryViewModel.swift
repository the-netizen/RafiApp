//
//  JournalHistoryViewModel.swift
//  Rafi
//
//  Created by Noor Alhassani on 20/06/1447 AH.
//

import Foundation
import Combine

class JournalHistoryViewModel: ObservableObject {
    

    // 🔹 Entries shown in the list
    @Published var entries: [JournalEntry] = [
        JournalEntry(title: "Morning Thoughts",
                     date: Date(),
                     heartLevel: 1,
                     audioURL: nil),
        JournalEntry(title: "Evening Reflection",
                     date: Date().addingTimeInterval(-86400),
                     heartLevel: 1,
                     audioURL: nil),
        JournalEntry(title: "Weekend Plans",
                     date: Date().addingTimeInterval(-172800),
                     heartLevel: 3,
                     audioURL: nil),
        JournalEntry(title: "Daily Goals",
                     date: Date().addingTimeInterval(-259200),
                     heartLevel: 2,
                     audioURL: nil)
    ]

    @Published var isRecording: Bool = false

    private let recorder = AudioRecorderService()

    /// Called when user taps the mic button
    func toggleRecordingAndMaybeCreateEntry() {
        if isRecording {
            stopRecordingAndCreateEntry()
        } else {
            startRecording()
        }
    }

    private func startRecording() {
        recorder.startRecording()
        isRecording = true
    }

    private func stopRecordingAndCreateEntry() {
        if let url = recorder.stopRecording() {
            let newEntry = JournalEntry(
                title: defaultTitleForNewEntry(),  // 🔹 auto title for now
                date: Date(),
                heartLevel: 1,
                audioURL: url
            )

            // put newest on top
            entries.insert(newEntry, at: 0)
        }
        isRecording = false
    }

    private func defaultTitleForNewEntry() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return "Recording \(formatter.string(from: Date()))"
    }
}
