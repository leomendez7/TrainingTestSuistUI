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
    @State var transactions = [Trade]()
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationStack(path: $store.transactions) {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.groupedTransactions.keys.sorted(by: >), id: \.self) { date in
                        if let dateTransactions = viewModel.groupedTransactions[date] {
                            TransactionSectionDayView(date: date,
                                                      transactions: dateTransactions,
                                                      selectedTrade: $selectedTrade,
                                                      viewModel: viewModel)
                        }
                    }
                }
            }
            .transactionToolbar(isSheetPresented: $isSheetPresented)
            .environmentObject(Constants.homeViewModel)
            .navigationDestination(for: String.self, destination: { route in
                switch route {
                case "TransactionDetails":
                    TransactionDetailsView(selectedTrade: $selectedTrade, viewModel: Constants.transactionDetailsViewModel)
                default:
                    EmptyView()
                }
            })
        }
        .onAppear {
            Task {
                await viewModel.fetchTransactions()
            }
        }
    }
    
    func addTransactions(trades: [Trade]) {
        
    }
    
}

#Preview {
    VStack {
        TransactionsView(viewModel: Constants.transactionViewModel)
            .environmentObject(Store())
    }
}

