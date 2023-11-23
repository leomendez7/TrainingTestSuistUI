//
//  HomeView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI
import Domain

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var store: Store
    @State var isIncome = Bool()
    @State var isIncomeSelected = false
    @State var isExpensesSelected = false
    @State var isChangeMonth = false
    @State var seeAll = false
    @State var selectedTrade = Trade()
    @State private var isSheetPresented = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack(path: $store.transactions) {
            VStack {
                ScrollView {
                    BalanceComponentView(balance: viewModel.balance, income: viewModel.incomeValue, expense: viewModel.expensesValue)
                    FrequencyView()
                    RecentTransactionView(seeAll: $seeAll, selectedTrade: $selectedTrade)
                }
            }
            .preferredColorScheme(.light)
            .onAppear {
                viewModel.generateMonths()
                Task {
                    await viewModel.fetchTransactions()
                }
            }
            .onChange(of: isIncomeSelected) { _ in
                isIncome = true
                store.transactions.append("NewTransaction")
            }
            .onChange(of: isExpensesSelected) { _ in
                isIncome = false
                store.transactions.append("NewTransaction")
            }
            .onChange(of: seeAll) { _ in
                viewModel.seeAll = seeAll
                Task {
                    await viewModel.fetchTransactions()
                }
            }
            .onChange(of: isChangeMonth) { _ in
                Task {
                    await viewModel.fetchTransactions()
                }
            }
            .onReceive(viewModel.$success) { newValue in
                isLoading = !newValue
            }
            .onChange(of: viewModel.loading) { newValue in
                isLoading = newValue
            }
            .overlay(
                isLoading ?
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
            .navigationDestination(for: String.self, destination: { route in
                switch route {
                case "NewTransaction":
                    NewTransactionView(balance: viewModel.balance, isIncome: $isIncome)
                case "TransactionDetails":
                    TransactionDetailsView(selectedTrade: $selectedTrade, viewModel: Constants.transactionDetailsViewModel)
                default:
                    EmptyView()
                }
            })
            .homeTransactionToolbar(image: "avatar-2",
                                    isSheetPresented: $isSheetPresented,
                                    incomeSelected: $isIncomeSelected,
                                    expensesSelected: $isExpensesSelected,
                                    months: $viewModel.months,
                                    currentMonth: $viewModel.currentMonth,
                                    selectedMont: $viewModel.selectedMont, 
                                    changeMonth: $isChangeMonth)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .environmentObject(viewModel)
        }
        .toolbarColorScheme(.light, for: .navigationBar)
    }
    
}

#Preview {
    NavigationStack {
        HomeView(viewModel: Constants.homeViewModel)
            .environmentObject(Store())
    }
}
