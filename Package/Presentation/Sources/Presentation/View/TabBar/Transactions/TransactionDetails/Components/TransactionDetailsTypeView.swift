//
//  TransactionDetailsTypeView.swift
//
//
//  Created by Leonardo Mendez on 20/11/23.
//

import SwiftUI

struct TransactionDetailsTypeView: View {
    
    @Binding var isIncome: Bool
    @Binding var category: String
    @Binding var wallet: String
    @State private var typeString: String = ""
    
    var body: some View {
        HStack() {
            VStack(spacing: 8) {
                Text("Type")
                    .foregroundColor(Color(.light20))
                    .font(.system(size: 14))
                Text(typeString)
                    .font(.system(size: 16))
            }
            Spacer()
            VStack(spacing: 8) {
                Text("Category")
                    .foregroundColor(Color(.light20))
                    .font(.system(size: 14))
                Text(category)
                    .font(.system(size: 16))
            }
            Spacer()
            VStack(spacing: 8) {
                Text("Wallet")
                    .foregroundColor(Color(.light20))
                    .font(.system(size: 14))
                Text(wallet)
                    .font(.system(size: 16))
            }
        }
        .padding(16)
        .background(Color(.white))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.light60), lineWidth: 1)
        )
        .onAppear {
            typeString = isIncome ? "Income" : "Expense"
        }
    }
}

#Preview {
    TransactionDetailsTypeView(isIncome: .constant(true),
                               category: .constant(""),
                               wallet: .constant(""))
}
