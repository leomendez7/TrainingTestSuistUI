//
//  ValueTextFieldView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 3/11/23.
//

import SwiftUI

struct ValueTransactionTextFieldView: View {
    
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("How much?")
                .padding(.horizontal, 16)
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(Color(.light80))
                .opacity(0.64)
            HStack {
                Text("$")
                    .foregroundColor(Color(.light80))
                    .font(.system(size: 64))
                    .fontWeight(.bold)
                    .padding(.leading, 16)
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(Color(.light80))
                            .font(.system(size: 64))
                            .fontWeight(.bold)
                    }
                    TextField("", text: $text)
                        .foregroundColor(Color(.light80))
                        .font(.system(size: 64))
                        .fontWeight(.bold)
                        .padding(.trailing, 16)
                        .keyboardType(.decimalPad)
                }
            }
        }
    }
}

#Preview {
    ValueTransactionTextFieldView(text: .constant("0"), placeholder: "0")
}
