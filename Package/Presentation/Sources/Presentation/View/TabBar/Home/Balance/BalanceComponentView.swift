//
//  BalanceComponentView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI

struct BalanceComponentView: View {
    
    var balance: String
    var income: String
    var expense: String
    
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
                IncomeComponentView(income: income)
                ExpensesView(expense: expense)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    BalanceComponentView(balance: "9400", income: "5000", expense: "1200")
}
