//
//  TwoIconsVIew.swift
//  Life
//
//  Created by Victor Ramirez on 9/16/24.
//

import SwiftUI

struct TwoIconsView: View {
    var accentColor: Color
    var onClockTap: () -> Void
    
    var body: some View {
        HStack {
            NeumorphicIconButton(iconName: "clock.arrow.circlepath", color: accentColor, action: onClockTap)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    TwoIconsView(accentColor: Color.blue, onClockTap: {})
}

