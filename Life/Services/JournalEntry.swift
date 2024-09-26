//
//  JournalEntry.swift
//  Life
//
//  Created by Victor Ramirez on 9/24/24.
//

import Foundation

struct JournalEntry: Identifiable, Codable {
    let id: UUID
    let entry: String
    let timestamp: String
    
    init(id: UUID = UUID(), entry: String, timestamp: String) {
        self.id = id
        self.entry = entry
        self.timestamp = timestamp
    }
}

