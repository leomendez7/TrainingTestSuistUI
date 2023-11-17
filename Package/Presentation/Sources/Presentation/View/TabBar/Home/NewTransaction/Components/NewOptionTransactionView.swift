//
//  NewTransactionView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import SwiftUI

struct NewOptionTransactionView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: Store
    @Binding var isIncomeSelected: Bool
    @Binding var isExpensesSelected: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                Text("Create transaction")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Spacer()
                VStack(alignment: .leading) {
                    Button {
                        dismiss()
                    } label: {
                        Image("close", bundle: .module)
                            .frame(width: 32, height: 32)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            VStack(spacing: 16) {
                CustomButton(action: {
                    isIncomeSelected.toggle()
                    dismiss()
                }, text: "Income", color: Color(.green100), foregroundColor: .white)
                CustomButton(action: {
                    isExpensesSelected.toggle()
                    dismiss()
                }, text: "Expenses", color: Color(.red100), foregroundColor: .white)
            }
        }
        .background(Color.white)
        .cornerRadius(16)
    }
}

#Preview {
    NewOptionTransactionView(isIncomeSelected: .constant(true), isExpensesSelected: .constant(true))
}
