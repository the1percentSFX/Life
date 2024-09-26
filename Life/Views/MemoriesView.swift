//
//  MemoriesView.swift
//  Life
//
//  Created by Victor Ramirez on 9/17/24.
//

import SwiftUI

struct MemoriesView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedDate: String?
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    
    var body: some View {
        NavigationView {
            ScrollView {
                if appState.journalEntries.isEmpty {
                    Text("No memories yet. Start journaling to create some!")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(getDateRange(), id: \.self) { date in
                            if let entry = appState.journalEntries.first(where: { $0.value.timestamp == date }) {
                                Text(formatDate(date))
                                    .padding()
                                    .background(Color.blue)
                                    .clipShape(Circle())
                                    .foregroundColor(.white)
                                    .onTapGesture {
                                        selectedDate = date
                                    }
                            } else {
                                Text(formatDate(date))
                                    .padding()
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Memories")
            .sheet(item: Binding(
                get: { selectedDate.map { StringIdentifiable(id: $0) } },
                set: { selectedDate = $0?.id }
            )) { date in
                if let entry = appState.journalEntries.first(where: { $0.value.timestamp == date.id })?.value {
                    EntryDetailView(entry: entry)
                }
            }
        }
        .onAppear(perform: loadEntries)
    }
    
    func getDateRange() -> [String] {
        // This is a placeholder. In a real app, you'd want to dynamically generate this based on your entries.
        let calendar = Calendar.current
        let startDate = calendar.date(from: DateComponents(year: 2024, month: 10, day: 1))!
        return (0..<31).map { day in
            let date = calendar.date(byAdding: .day, value: day, to: startDate)!
            return ISO8601DateFormatter().string(from: date)
        }
    }
    
    func loadEntries() {
        APIService.shared.fetchJournalEntries { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let entries):
                    self.appState.journalEntries = Dictionary(uniqueKeysWithValues: entries.map { ($0.id, $0) })
                case .failure(let error):
                    print("Failed to fetch entries: \(error)")
                    // Handle the error (e.g., show an alert to the user)
                }
            }
        }
    }
    
    func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "d"
            return dayFormatter.string(from: date)
        }
        return ""
    }
}

struct StringIdentifiable: Identifiable {
    let id: String
}

struct EntryDetailView: View {
    let entry: JournalEntry
    
    var body: some View {
        VStack {
            Text(formatDate(entry.timestamp))
                .font(.title)
            Text(entry.entry)
                .padding()
        }
    }
    
    func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .long
            return displayFormatter.string(from: date)
        }
        return dateString
    }
}

extension Date: Identifiable {
    public var id: String {
        return self.formatted(.iso8601)
    }
}

struct MemoriesView_Previews: PreviewProvider {
    static var previews: some View {
        MemoriesView().environmentObject(AppState())
    }
}


