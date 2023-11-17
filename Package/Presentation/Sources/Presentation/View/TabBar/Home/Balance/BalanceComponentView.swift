//
//  BalanceComponentView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI

struct BalanceComponentView: View {
    
    @Binding var balance: String
    @Binding var income: String
    @Binding var expense: String
    
    var body: some View {
        VStack {
            VStack(spacing: 9) {
                Text("Account Balance")
                    .font(.system(size: 14))
                    .foregroundColor(Color(.light20))
                Text("$\(balance)")
                    .font(.system(size: 40))
                    .foregroundColor(Color(.dark75))
                    .fontWeight(.bold)
            }
            .padding(.top, 9)
            HStack(spacing: 16) {
                IncomeComponentView(income: $income)
                ExpensesView(expense: $expense)
            }
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
    }
}

#Preview {
    BalanceComponentView(balance: .constant("9400"), income: .constant("5000"), expense: .constant("1200"))
}
