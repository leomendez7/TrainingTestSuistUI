//
//  TransactionDetailsView.swift
//
//
//  Created by Leonardo Mendez on 17/11/23.
//

import SwiftUI
import Domain

struct TransactionDetailsView: View {
    
    @State private var isSheetPresented = false
    @State var isRemove: Bool = false
    @State var isIncome: Bool = false
    @Binding var selectedTrade: Trade
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: Store
    @StateObject var viewModel: TransactionDetailsViewModel
    @State private var backgroundColor: Color = Color(.green100)
    
    var body: some View {
        VStack {
            GeometryReader { reader in
                ZStack {
                    VStack {
                        TransactionDetailsHeaderView(transaction: $selectedTrade)
                            .frame(height: reader.size.height * 0.35)
                        TransactionDetailsTypeView(
                            isIncome: $selectedTrade.isIncome,
                            category: $selectedTrade.category,
                            wallet: $selectedTrade.payment
                        ).offset(y: -40)
                            .padding(.horizontal, 16)
                        TransactionDetailsDescriptionView(description: $selectedTrade.description, image: $selectedTrade.image)
                            .padding(.horizontal, 16)
                            .offset(y: -20)
                        Spacer()
                    }
                }
            }
        }
        .ignoresSafeArea()
        .transactionDetailsToolbar(isSheetPresented: $isSheetPresented, isRemove: $isRemove)
        .navigationBarItems(leading: BackNavigationButton(action: {
            store.transactions.removeLast()
        }, image: "arrow-left", color: Color(.light80)))
        .onAppear {
            isIncome = selectedTrade.isIncome
            backgroundColor = isIncome ? Color(.green100) : Color(.red100)
        }
        .onChange(of: isRemove) { _ in
            Task {
                await viewModel.removeTransactions(trade: selectedTrade)
            }
        }
    }
    
    func configureView() {
        
    }
    
}

#Preview {
    TransactionDetailsView(selectedTrade: .constant(Trade()), viewModel: Constants.transactionDetailsViewModel)
        .environmentObject(Store())
}
