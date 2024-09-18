//
//  RRAPI.swift
//  Life
//
//  Created by Victor Ramirez on 8/28/24.
//

import Foundation

struct JournalEntry: Codable {
    let content: String
    let date: Date
}

class RRAPI {
    static let shared = RRAPI()
    private let baseURL = "https://your-railway-app-url.com/api" // Replace with your actual Railway API URL
    
    func saveJournalEntry(_ entry: JournalEntry, completion: @escaping (Result<Void, Error>) -> Void) {
        // Implementation of API call to save journal entry
    }
}

