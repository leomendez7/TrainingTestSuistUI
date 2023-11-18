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
    @State var selectedTrade = Trade()
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationStack(path: $store.transactions) {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.groupedTransactions.keys.sorted(by: >), id: \.self) { date in
                        TransactionSectionDayView(date: date, 
                                                  transactions: viewModel.groupedTransactions[date]!,
                                                  selectedTrade: $selectedTrade,
                                                  viewModel: viewModel)
                    }
                }
            }
            .transactionToolbar(isSheetPresented: $isSheetPresented)
            .environmentObject(Constants.homeViewModel)
            .navigationDestination(for: String.self, destination: { route in
                switch route {
                case "TransactionDetails":
                    TransactionDetailsView(viewModel: Constants.transactionDetailsViewModel)
                default:
                    EmptyView()
                }
            })
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

