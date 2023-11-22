//
//  HomeView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI
import Domain

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    @EnvironmentObject var store: Store
    @State var isIncome = Bool()
    @State var isIncomeSelected = false
    @State var isExpensesSelected = false
    @State var seeAll = false
    @State var incomeValue = ""
    @State var expensesValue = ""
    @State var balance = ""
    @State var selectedTrade = Trade()
    @State private var isSheetPresented = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack(path: $store.transactions) {
            VStack {
                ScrollView {
                    BalanceComponentView(balance: $balance, income: $incomeValue, expense: $expensesValue)
                    FrequencyView()
                    RecentTransactionView(seeAll: $seeAll, selectedTrade: $selectedTrade)
                }
            }
            .preferredColorScheme(.light)
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
            .onAppear {
                Task {
                    await viewModel.fetchTransactions()
                }
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
            .onReceive(viewModel.$incomeValue) { newValue in
                incomeValue = newValue
            }
            .onReceive(viewModel.$expensesValue) { newValue in
                expensesValue = newValue
            }
            .onReceive(viewModel.$balance) { newValue in
                balance = newValue
            }
            .onReceive(viewModel.$success) { newValue in
                isLoading = !newValue
            }
            .navigationDestination(for: String.self, destination: { route in
                switch route {
                case "NewTransaction":
                    NewTransactionView(isIncome: $isIncome, balance: balance)
                case "TransactionDetails":
                    TransactionDetailsView(selectedTrade: $selectedTrade, viewModel: Constants.transactionDetailsViewModel)
                default:
                    EmptyView()
                }
            })
            .homeTransactionToolbar(image: "avatar-2", isSheetPresented: $isSheetPresented, incomeSelected: $isIncomeSelected, expensesSelected: $isExpensesSelected)
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
