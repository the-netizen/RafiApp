//
//  VoiceNote.swift
//  Rafi
//
//  Created by Noor Alhassani on 22/06/1447 AH.
//

import Foundation

struct VoiceNote: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    let createdAt: Date
    let fileName: String

    var fileURL: URL {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return docs.appendingPathComponent("Recordings", isDirectory: true)
            .appendingPathComponent(fileName)
    }
}
