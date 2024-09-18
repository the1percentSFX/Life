//
//  Starthere.swift
//  Life
//
//  Created by Victor Ramirez on 8/28/24.
//

import Foundation
import SwiftUI

struct StartHereView: View {
    @Binding var isEditing: Bool
    @Binding var journalText: String
    var textColor: Color
    var accentColor: Color
    var backgroundColor: Color
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                if isEditing {
                    SeamlessTextEditor(text: $journalText, textColor: textColor, accentColor: accentColor, backgroundColor: backgroundColor)
                        .padding()
                    
                    JournalActionButtons(
                        onSave: {
                            // Implement save functionality
                            isEditing = false
                        },
                        onDiscard: {
                            journalText = ""
                            isEditing = false
                        },
                        accentColor: accentColor
                    )
                } else {
                    Text("Start here...")
                        .font(.custom("Baskerville", size: 28))
                        .foregroundColor(Color.primary.opacity(0.6))
                        .onTapGesture {
                            isEditing = true
                        }
                }
            }
        }
    }
}

#Preview {
    StartHereView(isEditing: .constant(false), journalText: .constant(""), textColor: .primary, accentColor: .blue, backgroundColor: Color(UIColor.secondarySystemBackground))
}


