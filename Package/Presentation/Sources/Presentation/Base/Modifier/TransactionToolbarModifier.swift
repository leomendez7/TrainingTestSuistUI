//
//  File.swift
//  
//
//  Created by Leonardo Mendez on 11/11/23.
//

import SwiftUI

struct TransactionToolbarModifier: ViewModifier {
    
    @Binding var isSheetPresented: Bool
    @State var isIncomeSelected = false
    @State var isExpensesSelected = false
    
    func body(content: Content) -> some View {
        content
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    MonthSwitcherView()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isSheetPresented.toggle()
                    }) {
                        Image("filter", bundle: .module)
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                    .sheet(isPresented: $isSheetPresented) {
                        NewOptionTransactionView(isIncomeSelected: $isIncomeSelected,
                                                 isExpensesSelected: $isExpensesSelected)
                        .presentationDetents([.fraction(0.25)])
                    }
                }
            })
            .onChange(of: isIncomeSelected) { _ in
                
            }
            .onChange(of: isExpensesSelected) { _ in
                
            }
    }
    
}

extension View {
    
    func transactionToolbar(isSheetPresented: Binding<Bool>)  -> some View {
        return modifier(TransactionToolbarModifier(isSheetPresented: isSheetPresented))
    }
    
}
