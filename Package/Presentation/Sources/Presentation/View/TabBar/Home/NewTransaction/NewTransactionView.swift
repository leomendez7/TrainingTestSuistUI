//
//  NewExpenseView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import SwiftUI
import Shared

struct NewTransactionView: View {
    
    var balance: String
    @Binding var isIncome: Bool
    @State var tittle: String = ""
    @State var value: String = ""
    @State private var showCustomAlert = false
    @State private var backgroundColor: Color = Color(.green100)
    @EnvironmentObject var store: Store
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isIncome {
                Color(.green100)
                    .ignoresSafeArea()
            } else {
                Color(.red100)
                    .ignoresSafeArea()
            }
            VStack(alignment: .leading) {
                ValueTransactionTextFieldView(text: $value, placeholder: "0")
                TransactionOptionView(balance: balance, 
                                      isIncome: isIncome,
                                      value: $value,
                                      showCustomAlert: $showCustomAlert,
                                      viewModel: Constants.newTransactionViewModel)
                .frame(height: (UIScreen.main.bounds.size.height * 0.60) + 15)
            }.background(backgroundColor)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear {
            tittle = isIncome ? "Income" : "Expenses"
            backgroundColor = isIncome ? Color(.green100) : Color(.red100)
        }
        .preferredColorScheme(.dark)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .navigationBarItems(leading: BackNavigationButton(action: {
            store.transactions.removeLast()
        }, image: "arrow-left", color: Color(.light80)))
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text(tittle)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(Color(.light100))
            }
        })
        .overlay(
            CustomAlertView(isPresented: $showCustomAlert, action: {})
            .onTapGesture {
                store.transactions.removeLast()
            }
            .opacity(showCustomAlert ? 1 : 0)
        )
    }
    
}

#Preview {
    NavigationStack {
        NewTransactionView(balance: "900", isIncome: .constant(true))
            .environmentObject(Store())
    }
}
