//
//  TransactionDetailsToolbarModifier.swift
//
//
//  Created by Leonardo Mendez on 18/11/23.
//

import SwiftUI

struct TransactionDetailsToolbarModifier: ViewModifier {
    
    @Binding var isSheetPresented: Bool
    @State var isRemove: Bool
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    Text("Transaction Detail")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(Color(.light100))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isSheetPresented.toggle()
                    }) {
                        Image("trash", bundle: .module)
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                    .sheet(isPresented: $isSheetPresented) {
                        ConfirmationView(isSheetPresented: isSheetPresented,
                                         title: "Remove this transaction?",
                                         bodyText: "Are you sure do you wanna remove this transaction?",
                                         activeAction: $isRemove)
                        .presentationDetents([.fraction(0.25)])
                    }
                }
            })
    }
    
}

extension View {
    
    func transactionDetailsToolbar(isSheetPresented: Binding<Bool>, isRemove: Bool)  -> some View {
        return modifier(TransactionDetailsToolbarModifier(isSheetPresented: isSheetPresented, isRemove: isRemove))
    }
    
}
