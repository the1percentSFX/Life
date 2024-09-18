//
//  TypeVIew.swift
//  Life
//
//  Created by Victor Ramirez on 9/16/24.
//

import SwiftUI

struct TypeVIew: View {
    @Binding var isEditing: Bool
    
    var body: some View {
        Text("Start here...")
            .font(.custom("Baskerville", size: 28))
            .foregroundColor(Color.primary.opacity(0.6))
            .onTapGesture {
                isEditing = true
            }
    }
}

#Preview {
    TypeVIew(isEditing: .constant(false))
}

