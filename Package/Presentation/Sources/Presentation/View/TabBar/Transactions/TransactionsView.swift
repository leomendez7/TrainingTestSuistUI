//
//  TransactionsView.swift.swift
//
//
//  Created by Leonardo Mendez on 10/11/23.
//

import SwiftUI
import Domain

struct TransactionsView: View {
    
    @StateObject var viewModel: TransactionsViewModel
    @State private var isSheetPresented = false
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.groupedTransactions.keys.sorted(by: >), id: \.self) { date in
                        TransactionSectionDayView(date: date, transactions: viewModel.groupedTransactions[date]!, viewModel: viewModel)
                    }
                }
            }
            .transactionToolbar(isSheetPresented: $isSheetPresented)
            .environmentObject(Constants.homeViewModel)
        }
        .padding(.horizontal, 16)
        .onAppear {
            Task {
                await viewModel.fetchTransactions()
            }
        }
    }
    
}

#Preview {
    VStack {
        TransactionsView(viewModel: Constants.transactionViewModel)
            .environmentObject(Store())
    }
}

