//
//  APIService.swift
//  Life
//
//  Created by Victor Ramirez on 9/24/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case noData
    case decodingError
    case networkError(Error)
}

class APIService {
    static let shared = APIService()
    private init() {}
    
    private let baseURL = "http://127.0.0.1:5000" // Make sure this matches your Flask server's address
    
    func saveJournalEntry(_ entry: JournalEntry, completion: @escaping (Result<Void, APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/save_entry") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        do {
            request.httpBody = try encoder.encode(entry)
        } catch {
            completion(.failure(.decodingError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.networkError(NSError(domain: "", code: 0, userInfo: nil))))
                return
            }
            
            completion(.success(()))
        }.resume()
    }
    
    func fetchJournalEntries(completion: @escaping (Result<[JournalEntry], APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/get_entries") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let entries = try decoder.decode([JournalEntry].self, from: data)
                completion(.success(entries))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

