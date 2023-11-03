//
//  BalanceComponentView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI

struct BalanceComponentView: View {
    
    @State var balance: String = ""
    @State var income: String = ""
    @State var expense: String = ""
    
    var body: some View {
        VStack {
            VStack(spacing: 9) {
                Text("Account Balance")
                    .font(.system(size: 14))
                    .foregroundColor(.light20)
                Text("$\(balance)")
                    .font(.system(size: 40))
                    .foregroundColor(.dark75)
                    .fontWeight(.bold)
            }
            .padding(.top, 9)
            HStack(spacing: 16) {
                IncomeComponentView(income: income)
                ExpensesView(expense: expense)
            }
        }
        .padding(.leading, 16)
        .padding(.trailing, 16)
    }
}

#Preview {
    BalanceComponentView(balance: "9400", income: "5000", expense: "1200")
}
