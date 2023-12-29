//
//  FilterByView.swift
//
//
//  Created by Leonardo Mendez on 28/11/23.
//

import SwiftUI

struct FilterByView: View {
    
    @Binding var filterCount: Int
    @Binding var reset: Bool
    @State var colorIncome: Color = .white
    @State var foregroundColorIncome: Color = Color(.dark)
    @State var colorExpense: Color = .white
    @State var foregroundColorExpense: Color = Color(.dark)
    @State var isSelected: Bool = false
    @State var isIncome: Bool = false
    @State var isExpenses: Bool = false
    @EnvironmentObject var viewModel: TransactionsViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Filter By")
                    .textModifierStyle(size: 16, color: Color(.dark), weight: .semibold)
                Spacer()
            }
            HStack(spacing: 8) {
                SelectedButtonView(action: {
                    if !isSelected {  filterCount += 1 }
                    isSelected.toggle()
                    isIncome = true
                    isExpenses = false
                }, text: "Income", foregroundColor: foregroundColorIncome, backgroundColor: colorIncome)
                SelectedButtonView(action: {
                    if !isSelected {  filterCount += 1 }
                    isSelected.toggle()
                    isIncome = false
                    isExpenses = true
                }, text: "Expense", foregroundColor: foregroundColorExpense, backgroundColor: colorExpense)
                Spacer()
            }
        }
        .onAppear {
            isIncome = viewModel.isIncome
            isExpenses = viewModel.isExpenses
            colorIncome = isIncome ? Color(.violet20) : .white
            foregroundColorIncome = isIncome ? Color(.violet100) : Color(.dark)
            colorExpense = isExpenses ? Color(.violet20) : .white
            foregroundColorExpense = isExpenses ? Color(.violet100) : Color(.dark)
        }
        .onChange(of: isSelected) { _ in
            viewModel.activeFilter = true
            viewModel.isIncome = isIncome
            viewModel.isExpenses = isExpenses
            colorIncome = isIncome ? Color(.violet20) : .white
            foregroundColorIncome = isIncome ? Color(.violet100) : Color(.dark)
            colorExpense = isExpenses ? Color(.violet20) : .white
            foregroundColorExpense = isExpenses ? Color(.violet100) : Color(.dark)
            if filterCount == 0 { filterCount += 1 }
        }
        .onChange(of: reset) { _ in
            colorIncome = .white
            foregroundColorIncome = Color(.dark)
            colorExpense =  .white
            foregroundColorExpense =  Color(.dark)
        }
    }
    
}

#Preview {
    FilterByView(filterCount: .constant(0), reset: .constant(false))
        .environmentObject(Constants.transactionViewModel)
}
