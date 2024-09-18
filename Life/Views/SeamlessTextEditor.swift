//
//  SeamlessTextEditor.swift
//  Life
//
//  Created by Victor Ramirez on 9/16/24.
//

import SwiftUI
import UIKit

struct SeamlessTextEditor: UIViewRepresentable {
    @Binding var text: String
    var textColor: Color
    var accentColor: Color
    var backgroundColor: Color
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = UIFont(name: "Baskerville", size: 18)
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor(textColor)
        textView.tintColor = UIColor(accentColor)
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: SeamlessTextEditor
        
        init(_ parent: SeamlessTextEditor) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}

#Preview {
    SeamlessTextEditor(text: .constant(""), textColor: .primary, accentColor: .blue, backgroundColor: Color(UIColor.secondarySystemBackground))
}


