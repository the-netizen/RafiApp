//
//  VoiceNotesStore.swift
//  Rafi
//
//  Created by Noor Alhassani on 22/06/1447 AH.
//

import Foundation
import Combine

@MainActor
final class VoiceNotesStore: ObservableObject {
    @Published private(set) var notes: [VoiceNote] = []

    private let saveURL: URL = {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return docs.appendingPathComponent("voice_notes.json")
    }()

    init() {
        load()
    }

    func add(title: String, recordedFileURL: URL) {
        // نخزن فقط اسم الملف
        let note = VoiceNote(
            id: UUID(),
            title: title.isEmpty ? "Recording" : title,
            createdAt: Date(),
            fileName: recordedFileURL.lastPathComponent
        )
        notes.insert(note, at: 0)
        save()
    }

    func load() {
        guard let data = try? Data(contentsOf: saveURL) else { return }
        if let decoded = try? JSONDecoder().decode([VoiceNote].self, from: data) {
            notes = decoded
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(notes) {
            try? data.write(to: saveURL, options: [.atomic])
        }
    }
}
