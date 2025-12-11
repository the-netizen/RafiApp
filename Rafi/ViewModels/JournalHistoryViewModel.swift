//
//  JournalHistoryViewModel.swift
//  Rafi
//
//  Created by Noor Alhassani on 20/06/1447 AH.
//

import Foundation
import Combine

class JournalHistoryViewModel: ObservableObject {

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

    func addEntry(title: String, heartLevel: Int, audioURL: URL?) {
        let newEntry = JournalEntry(
            title: title,
            date: Date(),
            heartLevel: heartLevel,
            audioURL: audioURL
        )

        // newest on top
        entries.insert(newEntry, at: 0)
    }
}
