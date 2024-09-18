//
//  NeumorphicButton.swift
//  Life
//
//  Created by Victor Ramirez on 9/16/24.
//

import Foundation
import SwiftUI

struct NeumorphicButton: View {
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(#colorLiteral(red: 0.1647058824, green: 0.4784313725, blue: 0.7764705882, alpha: 1))) // Brighter blue
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
                        .shadow(color: Color(#colorLiteral(red: 0.2196078431, green: 0.5333333333, blue: 0.8313725490, alpha: 1)).opacity(0.3), radius: 5, x: -5, y: -5)
                )
        }
    }
}
