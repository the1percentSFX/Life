//
//  Save.swift
//  Life
//
//  Created by Victor Ramirez on 8/28/24.
//

import Foundation

class Save {
    static func saveJournalEntry(_ content: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let entry = JournalEntry(content: content, date: Date())
        RRAPI.shared.saveJournalEntry(entry, completion: completion)
    }
}

