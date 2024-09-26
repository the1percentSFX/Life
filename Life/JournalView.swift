import SwiftUI
import AVFoundation

struct JournalView: View {
    @EnvironmentObject var appState: AppState
    @State private var journalText: String = ""
    @State private var isEditing: Bool = false
    @State private var showingMemories = false
    @State private var saveStatus: String = ""

    let backgroundColor = Color(#colorLiteral(red: 0.1333333333, green: 0.1529411765, blue: 0.1882352941, alpha: 1))
    let textColor = Color(#colorLiteral(red: 0.7529411765, green: 0.7725490196, blue: 0.8, alpha: 1))
    let accentColor = Color(#colorLiteral(red: 0.1647058824, green: 0.4784313725, blue: 0.7764705882, alpha: 1))

    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor.edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()
                    
                    // Text editor for entering journal content
                    StartHereView(isEditing: $isEditing, journalText: $journalText, textColor: textColor, accentColor: accentColor, backgroundColor: backgroundColor)

                    Spacer()
                    
                    if isEditing {
                        // Save and Discard buttons when editing
                        JournalActionButtons(
                            onSave: {
                                saveJournalEntry()
                            },
                            onDiscard: {
                                journalText = ""
                                isEditing = false
                            },
                            accentColor: accentColor
                        )
                    } else {
                        // Show the two icons when not editing
                        TwoIconsView(accentColor: accentColor, onClockTap: {
                            showingMemories = true
                        })
                    }

                    // Display save status (success or failure)
                    Text(saveStatus)
                        .foregroundColor(.green)
                        .padding()
                }
                .padding(.horizontal, 30)
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingMemories) {
                MemoriesView()
            }
        }
    }
    
    private func saveJournalEntry() {
        guard !journalText.isEmpty else { return }
        let timestamp = ISO8601DateFormatter().string(from: Date())
        let newEntry = JournalEntry(entry: journalText, timestamp: timestamp)
        APIService.shared.saveJournalEntry(newEntry) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.saveStatus = "Journal entry saved successfully!"
                    self.journalText = ""
                    self.isEditing = false
                case .failure(let error):
                    self.saveStatus = "Failed to save journal entry: \(error.localizedDescription)"
                }
            }
        }
    }
}

struct NeumorphicIconButton: View {
    let iconName: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .font(.system(size: 24))
                .foregroundColor(color)
                .frame(width: 60, height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(#colorLiteral(red: 0.1333333333, green: 0.1529411765, blue: 0.1882352941, alpha: 1)))
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
                        .shadow(color: Color(#colorLiteral(red: 0.2, green: 0.2313725490, blue: 0.2823529412, alpha: 1)).opacity(0.3), radius: 5, x: -5, y: -5)
                )
        }
    }
}

#Preview {
    JournalView()
}




