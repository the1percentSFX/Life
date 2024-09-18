//
//  LifeApp.swift
//  Life
//
//  Created by Victor Ramirez on 8/28/24.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
}

@main
struct LifeApp: App {
    @StateObject private var appState = AppState()
    
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

