//
//  JournalEntry.swift
//  Rafi
//
//  Created by Noor Alhassani on 20/06/1447 AH.
//

import Foundation

struct JournalEntry: Identifiable {
    let id = UUID()
    var title: String
    var date: Date
    var heartLevel: Int
    var audioURL: URL? // where the recording is saved (optional)

    // Computed properties used by UI
    var heartImageName: String {
        switch heartLevel {
        case 1: return "Fullheart"
        case 2: return "Midheart"
        case 3: return "heart3"
        case 4: return "heart4"
        default: return "heart4"
        }
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
