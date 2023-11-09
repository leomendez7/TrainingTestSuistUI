//
//  PayMethodSelectorView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import SwiftUI

struct PayMethodSelectorView: View {
    
    @State private var selectedCategoryIndex = 0
    let payMethods = ["Wallet", "PayPal", "Chase"]
    
    var body: some View {
        Menu {
            ForEach(0..<payMethods.count, id: \.self) { index in
                Button(action: {
                    selectedCategoryIndex = index
                }) {
                    Text(payMethods[index])
                }
            }
        } label: {
            HStack {
                Text(payMethods[selectedCategoryIndex])
                    .font(.system(size: 18))
                    .foregroundColor(Color("light-20"))
                    .padding(.horizontal, 16)
                Spacer()
                Image("arrow-down-2")
                    .padding(.horizontal, 16)
            }
            .frame(height: 56)
            .background(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color("light-60"), lineWidth: 1)
            )
        }
    }
}

#Preview {
    PayMethodSelectorView()
}
