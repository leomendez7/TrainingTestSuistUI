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
    @Binding var incomeSelected: Bool
    @Binding var expensesSelected: Bool
    @Binding var months: [String]
    @Binding var selectedMont: String
    @Binding var currentMonth: Int
    @Binding var changeMonth: Bool
    @State var isIncomeSelected = false
    @State var isExpensesSelected = false
    @State var isChangeMonth = false
    
    func body(content: Content) -> some View {
        content
            .toolbar {
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
                    MonthSwitcherView(currentMonth: $currentMonth,
                                      months: $months,
                                      selectedMont: $selectedMont,
                                      isChangeMonth: $isChangeMonth)
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
            }
            .onChange(of: isIncomeSelected) { _ in
                incomeSelected.toggle()
            }
            .onChange(of: isExpensesSelected) { _ in
                expensesSelected.toggle()
            }
            .onChange(of: isChangeMonth) { _ in
                changeMonth.toggle()
            }
    }
    
}

extension View {
    
    func homeTransactionToolbar(image: String,
                                isSheetPresented: Binding<Bool>,
                                incomeSelected: Binding<Bool>,
                                expensesSelected: Binding<Bool>,
                                months: Binding<[String]>,
                                currentMonth: Binding<Int>  ,
                                selectedMont: Binding<String>,
                                changeMonth: Binding<Bool>) -> some View {
        return modifier(HomeToolbarModifier(image: image,
                                            isSheetPresented: isSheetPresented,
                                            incomeSelected: incomeSelected,
                                            expensesSelected: expensesSelected,
                                            months: months,
                                            selectedMont: selectedMont,
                                            currentMonth: currentMonth, 
                                            changeMonth: changeMonth))
    }
    
}
