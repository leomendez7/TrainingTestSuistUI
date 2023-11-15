//
//  PayMethodSelectorView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import SwiftUI

struct PayMethodSelectorView: View {
    
    @State private var selectedPaymentIndex = 0
    @Binding var selectedPayment: String
    let payMethods = ["Wallet", "PayPal", "Chase"]
    
    var body: some View {
        Menu {
            ForEach(0..<payMethods.count, id: \.self) { index in
                Button(action: {
                    selectedPaymentIndex = index
                }) {
                    Text(payMethods[index])
                }
            }
        } label: {
            HStack {
                Text(payMethods[selectedPaymentIndex])
                    .font(.system(size: 18))
                    .foregroundColor(Color(.light20))
                    .padding(.horizontal, 16)
                Spacer()
                Image("arrow-down-2", bundle: .module)
                    .padding(.horizontal, 16)
            }
            .frame(height: 56)
            .background(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.light60), lineWidth: 1)
            )
            .onChange(of: selectedPaymentIndex) { _ in
                selectedPayment = payMethods[selectedPaymentIndex]
            }
        }
    }
}

#Preview {
    PayMethodSelectorView(selectedPayment: .constant("Wallet"))
}
