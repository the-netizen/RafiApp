//
//  JournalHistoryViewModel.swift
//  Rafi
//
//  Created by Noor Alhassani on 20/06/1447 AH.
//
import Foundation
import Combine
internal import SwiftUI

class JournalHistoryViewModel: ObservableObject {

    // Entries shown in the list
    @Published var entries: [JournalEntry] = JournalHistoryViewModel.sampleEntries

    // For now we do NOT load or save from disk.
    // We just use sample data so the app is stable.

    // MARK: - Add new entry from recording screen
    func addEntry(title: String, heartLevel: Int, audioURL: URL?) {
        let newEntry = JournalEntry(
            title: title,
            date: Date(),
            heartLevel: heartLevel,
            audioURL: audioURL
        )

        // newest at the top
        entries.insert(newEntry, at: 0)
    }

    // Optional: later if you add swipe to delete
    func deleteEntry(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
    }

    // MARK: - Sample data (like before, so screen isn’t empty)
    private static let sampleEntries: [JournalEntry] = [
        JournalEntry(title: "Morning Thoughts",
                     date: Date(),
                     heartLevel: 1),
        JournalEntry(title: "Evening Reflection",
                     date: Date().addingTimeInterval(-86400),
                     heartLevel: 1),
        JournalEntry(title: "Weekend Plans",
                     date: Date().addingTimeInterval(-172800),
                     heartLevel: 3),
        JournalEntry(title: "Daily Goals",
                     date: Date().addingTimeInterval(-259200),
                     heartLevel: 2)
    ]
}
