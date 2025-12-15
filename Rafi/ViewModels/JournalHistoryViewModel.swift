//
//  JournalHistoryViewModel.swift
//  Rafi
//
//  Created by Noor Alhassani on 20/06/1447 AH.
//
import Foundation
internal import SwiftUI
import Combine

@MainActor
final class JournalHistoryViewModel: ObservableObject {
    @Published var entries: [JournalEntry] = []

    private let storage = JournalStorage()

    init() {
        load()
        if entries.isEmpty {
            seedDemo()
        }
    }

    func load() {
        entries = storage.load()
    }

    func save() {
        storage.save(entries)
    }

    func addEntry(title: String, rating: Int, audioFileName: String) {
        let new = JournalEntry(title: title, date: Date(), rating: rating, audioFileName: audioFileName)
        entries.insert(new, at: 0)
        save()
    }

    func updateRating(entryID: UUID, rating: Int) {
        guard let idx = entries.firstIndex(where: { $0.id == entryID }) else { return }
        entries[idx].rating = rating
        save()
    }

    private func seedDemo() {
        entries = [
            JournalEntry(title: "Morning Thoughts", date: Date().addingTimeInterval(-86400), rating: 4, audioFileName: ""),
            JournalEntry(title: "Evening Reflection", date: Date().addingTimeInterval(-172800), rating: 5, audioFileName: ""),
            JournalEntry(title: "Weekend Plans", date: Date().addingTimeInterval(-259200), rating: 3, audioFileName: ""),
            JournalEntry(title: "Daily Goals", date: Date().addingTimeInterval(-345600), rating: 2, audioFileName: "")
        ]
        save()
    }
}
