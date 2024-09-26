//
//  LifeApp.swift
//  Life
//
//  Created by Victor Ramirez on 8/28/24.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var journalEntries: [UUID: JournalEntry] = [:]
    
    func addJournalEntry(_ entry: JournalEntry) {
        APIService.shared.saveJournalEntry(entry) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.journalEntries[entry.id] = entry
                case .failure(let error):
                    print("Failed to save entry: \(error)")
                    // Handle the error (e.g., show an alert to the user)
                }
            }
        }
    }
    
    func loadJournalEntries() {
        APIService.shared.fetchJournalEntries { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let entries):
                    self.journalEntries = Dictionary(uniqueKeysWithValues: entries.map { ($0.id, $0) })
                case .failure(let error):
                    print("Failed to fetch entries: \(error)")
                    // Handle the error (e.g., show an alert to the user)
                }
            }
        }
    }
}

// Add this extension
extension Bundle {
    func infoDictionary(for key: String) -> [String: Any]? {
        guard let dict = infoDictionary?[key] as? [String: Any] else { return nil }
        return dict
    }
}

// Add this function
func configureAppTransportSecurity() {
    guard let bundleIdentifier = Bundle.main.bundleIdentifier else { return }
    
    var appTransportSecurity: [String: Any] = [
        "NSAllowsArbitraryLoads": true,
        "NSAllowsLocalNetworking": true
    ]
    
    if var existingDict = Bundle.main.infoDictionary(for: "NSAppTransportSecurity") {
        existingDict.merge(appTransportSecurity) { (_, new) in new }
        appTransportSecurity = existingDict
    }
    
    UserDefaults.standard.set(appTransportSecurity, forKey: bundleIdentifier + ".NSAppTransportSecurity")
}

@main
struct LifeApp: App {
    @StateObject private var appState = AppState()
    
    init() {
        configureAppTransportSecurity()
    }
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                JournalView()
                    .environmentObject(appState)
            } else {
                LoginView()
                    .environmentObject(appState)
            }
        }
    }
}


