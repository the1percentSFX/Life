//
//  LoginView.swift
//  Life
//
//  Created by Victor Ramirez on 9/15/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.1333333333, green: 0.1529411765, blue: 0.1882352941, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Sentio")
                    .font(.custom("Baskerville", size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color(#colorLiteral(red: 0.7529411765, green: 0.7725490196, blue: 0.8, alpha: 1)))
                    .padding(.top, 50)
                
                VStack(spacing: 15) {
                    NeumorphicTextField(text: $email, placeholder: "Email")
                    NeumorphicTextField(text: $password, placeholder: "Password", isSecure: true)
                }
                .padding(.top, 30)
                
                NeumorphicButton(text: "Log In") {
                    // Perform login action
                }
                .padding(.top, 20)
                
                Button(action: {
                    // Switch to sign up view
                }) {
                    Text("Need an account? Sign Up")
                        .font(.system(size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.5764705882, green: 0.5960784314, blue: 0.6352941176, alpha: 1)))
                }
                .padding(.top, 10)
                
                Spacer()
            }
            .padding(.horizontal, 30)
        }
    }
}

struct NeumorphicTextField: View {
    @Binding var text: String
    var placeholder: String
    var isSecure: Bool = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(#colorLiteral(red: 0.5764705882, green: 0.5960784314, blue: 0.6352941176, alpha: 1)))
                    .padding(.leading, 10)
            }
            if isSecure {
                SecureField("", text: $text)
            } else {
                TextField("", text: $text)
            }
        }
        .padding()
        .foregroundColor(Color(#colorLiteral(red: 0.7529411765, green: 0.7725490196, blue: 0.8, alpha: 1)))
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(#colorLiteral(red: 0.1333333333, green: 0.1529411765, blue: 0.1882352941, alpha: 1)))
                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                .shadow(color: Color(#colorLiteral(red: 0.2, green: 0.2313725490, blue: 0.2823529412, alpha: 1)).opacity(0.3), radius: 3, x: -3, y: -3)
        )
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}



