//
//  NewExpenseView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import SwiftUI

struct NewTransactionView: View {
    
    @State var isIncome = Bool()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            if isIncome {
                Color.green100
                    .ignoresSafeArea()
            } else {
                Color.red100
                    .ignoresSafeArea()
            }
            TransactionOptionView()
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    NewTransactionView(isIncome: false)
}
