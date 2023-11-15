//
//  NewExpenseView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import SwiftUI

struct NewTransactionView: View {
    
    @Binding var isIncome: Bool
    @State var tittle: String = ""
    @State var value: String = "0"
    @EnvironmentObject var viewModel: NewTransactionViewModel
    @EnvironmentObject var store: Store
    var backButton : some View {
        Button(action: {
            store.transactions.removeLast()
        }) {
            HStack {
                Image("arrow-left", bundle: .module)
                    .foregroundColor(Color(.light80))
            }
        }
    }
    
    var body: some View {
        ZStack {
            if isIncome {
                Color(.green100)
                    .ignoresSafeArea()
            } else {
                Color(.red100)
                    .ignoresSafeArea()
            }
            VStack(alignment: .leading) {
                Spacer()
                ValueTransactionTextFieldView(text: $value)
                TransactionOptionView(value: $value)
            }
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    hideKeyboard()
                }
        }
        .onAppear{
            tittle = isIncome ? "Income" : "Expenses"
        }
        .preferredColorScheme(.dark)
        .ignoresSafeArea()
        .navigationBarItems(leading: backButton)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text(tittle)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(Color(.light100))
            }
        })
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil,
                                        from: nil,
                                        for: nil)
    }
}

#Preview {
    NavigationStack {
        NewTransactionView(isIncome: .constant(true))
    }
}
