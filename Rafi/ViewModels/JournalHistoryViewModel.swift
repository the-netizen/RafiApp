//
//  JournalHistoryViewModel.swift
//  Rafi
//
//  Created by Noor Alhassani on 20/06/1447 AH.
//
import Foundation
internal import SwiftUI
import Combine

class JournalHistoryViewModel: ObservableObject {
    // All entries that appear in your list
    @Published var entries: [JournalEntry] = []

    // Where we save the JSON file on the device
    private let saveURL: URL

    init() {
        let documents = FileManager.default.urls(for: .documentDirectory,
                                                 in: .userDomainMask).first!
        self.saveURL = documents.appendingPathComponent("journal_entries.json")

        // Try to load previous data
        loadEntries()

        // If nothing saved yet, fill with sample entries once
        if entries.isEmpty {
            entries = Self.sampleEntries
            saveEntries()
        }
    }

    // MARK: - PUBLIC METHODS

    /// Called from the naming sheet when the user taps "Add"
    func addEntry(title: String, heartLevel: Int, audioURL: URL?) {
        let newEntry = JournalEntry(
            title: title,
            date: Date(),
            heartLevel: heartLevel,
            audioURL: audioURL
        )

        // newest at the top
        entries.insert(newEntry, at: 0)
        saveEntries()
    }

    /// If you ever add swipe-to-delete in the list
    func deleteEntry(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
        saveEntries()
    }

    // MARK: - SAMPLE DATA (for first launch)

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

    // MARK: - PERSISTENCE

    private func saveEntries() {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(entries)
            try data.write(to: saveURL, options: Data.WritingOptions.atomic)
            print("✅ Saved entries to:", saveURL.lastPathComponent)
        } catch {
            print("❌ Error saving entries:", error)
        }
    }

    private func loadEntries() {
        do {
            let data = try Data(contentsOf: saveURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let loaded = try decoder.decode([JournalEntry].self, from: data)
            self.entries = loaded
            print("📂 Loaded \(loaded.count) entries from disk")
        } catch {
            // First run or failed to load – we’ll handle by using sample entries
            print("ℹ️ No saved entries yet or failed to load:", error.localizedDescription)
        }
    }
}
