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
    @State var text: String = "0"
    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image("arrow-left")
                    .foregroundColor(.light80)
            }
        }
    }
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            if isIncome {
                Color.green100
                    .ignoresSafeArea()
            } else {
                Color.red100
                    .ignoresSafeArea()
            }
            VStack(alignment: .leading) {
                Spacer()
                ValueTransactionTextFieldView()
                TransactionOptionView()
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
        .ignoresSafeArea()
        .navigationBarItems(leading: backButton)
        .navigationBarBackButtonHidden(true)
        .navigationTitle(tittle)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil,
                                        from: nil,
                                        for: nil)
    }
}

#Preview {
    NewTransactionView(isIncome: .constant(Bool()))
}
