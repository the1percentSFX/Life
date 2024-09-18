//
//  SeamlessTextEditor.swift
//  Life
//
//  Created by Victor Ramirez on 9/16/24.
//

import SwiftUI

struct SeamlessTextEditor: View {
    @Binding var text: String
    var textColor: Color
    var accentColor: Color
    var backgroundColor: Color
    
    var body: some View {
        TextEditor(text: $text)
            .font(.custom("Baskerville", size: 18))
            .foregroundColor(textColor)
            .background(backgroundColor)
            .accentColor(accentColor) // Blue cursor
    }
}

#Preview {
    SeamlessTextEditor(text: .constant(""), textColor: .primary, accentColor: .blue, backgroundColor: Color(UIColor.secondarySystemBackground))
}

