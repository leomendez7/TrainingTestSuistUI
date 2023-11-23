//
//  File.swift
//  
//
//  Created by Leonardo Mendez on 11/11/23.
//

import SwiftUI

struct TransactionToolbarModifier: ViewModifier {
    
    @Binding var isSheetPresented: Bool
    @Binding var months: [String]
    @Binding var selectedMont: String
    @Binding var currentMonth: Int
    @Binding var changeMonth: Bool
    @State var isChangeMonth = false
    
    func body(content: Content) -> some View {
        content
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    MonthSwitcherView(currentMonth: $currentMonth,
                                      months: $months,
                                      selectedMont: $selectedMont,
                                      isChangeMonth: $isChangeMonth)
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
                        EmptyView()
                        .presentationDetents([.fraction(0.25)])
                    }
                }
            })
            .onChange(of: isChangeMonth) { _ in
                changeMonth.toggle()
            }
           
    }
    
}

extension View {
    
    func transactionToolbar(isSheetPresented: Binding<Bool>,
                            months: Binding<[String]>,
                            currentMonth: Binding<Int>,
                            selectedMont: Binding<String>,
                            changeMonth: Binding<Bool>)  -> some View {
        return modifier(TransactionToolbarModifier(isSheetPresented: isSheetPresented,
                                                   months: months,
                                                   selectedMont: selectedMont,
                                                   currentMonth: currentMonth, 
                                                   changeMonth: changeMonth))
    }
    
}
