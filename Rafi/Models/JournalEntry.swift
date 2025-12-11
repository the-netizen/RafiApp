//
//  JournalEntry.swift
//  Rafi
//
//  Created by Noor Alhassani on 20/06/1447 AH.
//
import Foundation

struct JournalEntry: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var date: Date
    var heartLevel: Int
    var audioURL: URL?

    init(
        id: UUID = UUID(),
        title: String,
        date: Date = Date(),
        heartLevel: Int,
        audioURL: URL? = nil
    ) {
        self.id = id
        self.title = title
        self.date = date
        self.heartLevel = heartLevel
        self.audioURL = audioURL
    }
}
