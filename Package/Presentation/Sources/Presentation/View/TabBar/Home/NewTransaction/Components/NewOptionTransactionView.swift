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
        NavigationStack() {
            VStack(spacing: 16) {
                CustomButton(action: {
                    isIncomeSelected.toggle()
                    dismiss()
                }, text: "Income", color: Color(.green100), foregroundColor: .white, bottom: 0)
                CustomButton(action: {
                    isExpensesSelected.toggle()
                    dismiss()
                }, text: "Expenses", color: Color(.red100), foregroundColor: .white, bottom: 0)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image("close", bundle: .module)
                        .frame(width: 32, height: 32)
                        .onTapGesture {
                            dismiss()
                        }
                }
                ToolbarItem(placement: .principal) {
                    Text("Create transaction")
                        .textModifierStyle(size: 18, color: Color(.dark), weight: .bold)
                }
            }
        }
        .background(Color.white)
        .cornerRadius(16)
    }
}

#Preview {
    NewOptionTransactionView(isIncomeSelected: .constant(true), isExpensesSelected: .constant(true))
}
