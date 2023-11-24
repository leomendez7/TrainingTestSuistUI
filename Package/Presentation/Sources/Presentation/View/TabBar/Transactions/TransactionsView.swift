//
//  TransactionsView.swift.swift
//
//
//  Created by Leonardo Mendez on 10/11/23.
//

import SwiftUI
import Domain

struct TransactionsView: View {
    
    @ObservedObject var viewModel: TransactionsViewModel
    @State private var isSheetPresented = false
    @State var selectedTrade = Trade()
    @State var transactions = [Trade]()
    @State private var isLoading = false
    @State var isChangeMonth = false
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
            .onAppear {
                viewModel.generateMonths()
                viewModel.loading = true
                Task {
                    await viewModel.fetchTransactions()
                }
            }
            .onChange(of: isChangeMonth) { _ in
                viewModel.loading = true
                Task {
                    await viewModel.fetchTransactions()
                }
            }
            .overlay(
                viewModel.loading ?
                ZStack {
                    Color.white.edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color(.violet100)))
                            .padding(20)
                        Spacer()
                    }
                }
                : nil
            )
            .transactionToolbar(isSheetPresented: $isSheetPresented,
                                months: $viewModel.months,
                                currentMonth: $viewModel.currentMonth,
                                selectedMont: $viewModel.selectedMont,
                                changeMonth: $isChangeMonth)
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
    }
    
}

#Preview {
    VStack {
        TransactionsView(viewModel: Constants.transactionViewModel)
            .environmentObject(Store())
    }
}

