//
//  Save.swift
//  Life
//
//  Created by Victor Ramirez on 8/28/24.
//

import Foundation

class Save {
    static func saveJournalEntry(_ content: String, completion: @escaping (Result<Void, Error>) -> Void) {
        // URL for your local Flask API
        guard let url = URL(string: "http://127.0.0.1:5000/save_entry") else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        // Create the request object
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Prepare the journal entry as JSON
        let journalEntry: [String: Any] = [
            "entry": content,
            "timestamp": ISO8601DateFormatter().string(from: Date())
        ]
        
        do {
            // Convert journalEntry dictionary to JSON data
            let jsonData = try JSONSerialization.data(withJSONObject: journalEntry, options: [])
            request.httpBody = jsonData
            
            // Create a URLSession data task to send the request
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error saving journal entry: \(error)")
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
                    print("Journal entry saved successfully")
                    completion(.success(()))
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to save entry"])
                    completion(.failure(error))
                }
            }
            task.resume()
        } catch {
            print("Error serializing JSON: \(error)")
            completion(.failure(error))
        }
    }
}

// Extension to format the date in ISO8601 for sending to Flask
extension Date {
    var iso8601: String {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
}

