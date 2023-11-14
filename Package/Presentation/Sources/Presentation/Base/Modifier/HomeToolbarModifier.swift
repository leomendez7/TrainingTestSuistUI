//
//  ToolbarModifier.swift
//
//
//  Created by Leonardo Mendez on 9/11/23.
//

import SwiftUI

struct HomeToolbarModifier: ViewModifier {
    
    var image: String
    @Binding var isSheetPresented: Bool
    @State var isIncomeSelected = false
    @State var isExpensesSelected = false
    @Binding var incomeSelected: Bool
    @Binding var expensesSelected: Bool
    
    func body(content: Content) -> some View {
        content
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Circle()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.white)
                        .overlay(
                            Image(image, bundle: .module)
                                .resizable()
                                .frame(width: 37, height: 37)
                        )
                }
                ToolbarItem(placement: .principal) {
                    MonthSwitcherView()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isSheetPresented.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(Color("violet-100", bundle: .module))
                    }
                    .sheet(isPresented: $isSheetPresented) {
                        NewOptionTransactionView(isIncomeSelected: $isIncomeSelected,
                                                 isExpensesSelected: $isExpensesSelected)
                        .presentationDetents([.fraction(0.25)])
                    }
                }
            })
            .onChange(of: isIncomeSelected) { _ in
                incomeSelected.toggle()
            }
            .onChange(of: isExpensesSelected) { _ in
                expensesSelected.toggle()
            }
    }
    
}

extension View {
    
    func homeTransactionToolbar(image: String, isSheetPresented: Binding<Bool>, incomeSelected: Binding<Bool>, expensesSelected: Binding<Bool>)  -> some View {
        return modifier(HomeToolbarModifier(image: image,
                                        isSheetPresented: isSheetPresented,
                                        incomeSelected: incomeSelected,
                                        expensesSelected: expensesSelected))
    }
    
}
