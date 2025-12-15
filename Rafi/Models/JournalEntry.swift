//
//  JournalEntry.swift
//  Rafi
//
import Foundation

struct JournalEntry: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var date: Date
    var rating: Int
    var audioFileName: String

    init(id: UUID = UUID(),
         title: String,
         date: Date = Date(),
         rating: Int = 0,
         audioFileName: String = "") {
        self.id = id
        self.title = title
        self.date = date
        self.rating = rating
        self.audioFileName = audioFileName
    }

    enum CodingKeys: String, CodingKey { case id, title, date, rating, audioFileName }

    //   audioFileName 
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(UUID.self, forKey: .id)
        title = try c.decode(String.self, forKey: .title)
        date = try c.decode(Date.self, forKey: .date)
        rating = try c.decode(Int.self, forKey: .rating)
        audioFileName = (try? c.decode(String.self, forKey: .audioFileName)) ?? ""
    }
}
