//
//  RootView.swift
//  Life
//
//  Created by Victor Ramirez on 8/28/24.
//

import SwiftUI
import AVFoundation

struct JournalView: View {
    @State private var journalText: String = ""
    @State private var isEditing: Bool = false
    
    let backgroundColor = Color(#colorLiteral(red: 0.1333333333, green: 0.1529411765, blue: 0.1882352941, alpha: 1))
    let textColor = Color(#colorLiteral(red: 0.7529411765, green: 0.7725490196, blue: 0.8, alpha: 1))
    let accentColor = Color(#colorLiteral(red: 0.1647058824, green: 0.4784313725, blue: 0.7764705882, alpha: 1))
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                StartHereView(isEditing: $isEditing, journalText: $journalText, textColor: textColor, accentColor: accentColor, backgroundColor: Color(UIColor.secondarySystemBackground))
                
                Spacer()
                
                TwoIconsView(accentColor: accentColor, onClockTap: {
                    // Implement clock tap functionality
                })
            }
            .padding(.horizontal, 30)
        }
    }
    
    private func saveJournalEntry() {
        // Implement save functionality
        isEditing = false
        journalText = ""
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

struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}

