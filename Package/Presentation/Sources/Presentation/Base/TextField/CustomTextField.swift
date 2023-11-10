//
//  CustomTextField.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

struct CustomTextField: View {
    
    @State var text: String
    var placeholder: String

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(.light20))
                    .padding(.horizontal, 16)
            }
            TextField("", text: $text)
                .padding(.horizontal, 16)
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
    CustomTextField(text: "", placeholder: "")
}
