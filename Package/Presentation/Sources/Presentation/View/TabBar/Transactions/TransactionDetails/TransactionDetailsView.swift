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
        ZStack() {
            TransactionDetailsTypeView(isIncome: $selectedTrade.isIncome,
                                       category: $selectedTrade.category,
                                       wallet: $selectedTrade.payment)
            VStack {
                TransactionDetailsHeaderView(transaction: $selectedTrade)
                    .frame(height: UIScreen.main.bounds.size.height * 0.35)
                TransactionDetailsDescriptionView(description: $selectedTrade.description)
                Spacer()
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
