//
//  NewExpenseView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import SwiftUI
import Shared

struct NewTransactionView: View {
    
    @Binding var isIncome: Bool
    @State var tittle: String = ""
    @State var value: String = ""
    @State var balance: String
    @EnvironmentObject var store: Store
    @State private var backgroundColor: Color = Color(.green100)
    
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
                TransactionOptionView(isIncome: isIncome, 
                                      balance: balance,
                                      value: $value,
                                      viewModel: Constants.newTransactionViewModel)
                    .frame(height: UIScreen.main.bounds.size.height * 0.60)
            }.background(backgroundColor)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear{
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
    }
    
}

#Preview {
    NavigationStack {
        NewTransactionView(isIncome: .constant(true), balance: "900")
            .environmentObject(Store())
    }
}
