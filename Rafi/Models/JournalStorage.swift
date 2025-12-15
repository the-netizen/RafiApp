//
//  JournalStorage.swift
//  Rafi
//
//  Created by Noor Alhassani on 24/06/1447 AH.
//

import Foundation

final class JournalStorage {
    private let key = "journal_entries_v1"

    func load() -> [JournalEntry] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            return try JSONDecoder().decode([JournalEntry].self, from: data)
        } catch {
            // لو صار خطأ، رجّع فاضي بدل crash
            return []
        }
    }

    func save(_ entries: [JournalEntry]) {
        do {
            let data = try JSONEncoder().encode(entries)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            //   crash
        }
    }
}
