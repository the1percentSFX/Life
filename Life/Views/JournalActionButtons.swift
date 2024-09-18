//
//  JournalActionButtons.swift
//  Life
//
//  Created by Victor Ramirez on 9/17/24.
//

import SwiftUI

struct JournalActionButtons: View {
    var onSave: () -> Void
    var onDiscard: () -> Void
    var accentColor: Color
    
    var body: some View {
        HStack {
            Button(action: onDiscard) {
                Text("Discard")
                    .foregroundColor(.red)
                    .padding()
                    .background(Color.clear)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.red, lineWidth: 1)
                    )
            }
            
            Spacer()
            
            Button(action: onSave) {
                Text("Save")
                    .foregroundColor(.white)
                    .padding()
                    .background(accentColor)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

#Preview {
    JournalActionButtons(onSave: {}, onDiscard: {}, accentColor: .blue)
}

