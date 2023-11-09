//
//  ExpensesView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI

struct ExpensesView: View {
    
    @State var expense: String = ""
    
    var body: some View {
        HStack(spacing: 10) {
            Image("expenses", bundle: .module)
                .padding(8)
                .frame(width: 48, height: 48)
                .background(.white)
                .cornerRadius(16)
            VStack(alignment: .leading, spacing: 4) {
                Text("Expenses")
                    .foregroundColor(.white)
                    .font(.system(size: 14))
                Text("$\(expense)")
                    .foregroundColor(.white)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
            }
        }
        .frame(width: 164, height: 80)
        .background(Color("red-100", bundle: .module))
        .cornerRadius(28)
    }
}

#Preview {
    ExpensesView(expense: "1200")
}
