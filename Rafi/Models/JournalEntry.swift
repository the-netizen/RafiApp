//
//  JournalEntry.swift
//  Rafi
//
//  Created by Noor Alhassani on 20/06/1447 AH.
//

import Foundation

struct JournalEntry: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var date: Date
    var heartLevel: Int
    var audioURL: URL?     // 🔹 where the audio is saved
}
