//
//  CustomPasswordTextField.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

struct CustomPasswordTextField: View {
    
    @Binding var password: String
    @State var isSecure: Bool = true
    var placeholder: String

    var body: some View {
        ZStack(alignment: .leading) {
            if password.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(.light20))
                    .padding(.horizontal, 16)
            }
            HStack {
                if isSecure {
                    SecureField("", text: $password)
                        .padding(.horizontal, 16)
                } else {
                    TextField("", text: $password)
                        .padding(.horizontal, 16)
                }
                Button(action: {
                    isSecure.toggle()
                }) {
                    Image(systemName: isSecure ? "eye.slash" : "eye")
                        .foregroundColor(Color(.light20))
                        .padding(8)
                }
            }
            
        }
        .frame(height: 56)
        .background(.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.light60), lineWidth: 1)
        )
    }
}

#Preview {
    CustomPasswordTextField(password: .constant(""), placeholder: "password")
}
