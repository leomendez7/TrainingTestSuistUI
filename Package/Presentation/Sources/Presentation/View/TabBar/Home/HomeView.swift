//
//  HomeView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    @EnvironmentObject var store: Store
    @State var isIncome = Bool()
    @State private var isSheetPresented = false
    @State var isIncomeSelected = false
    @State var isExpensesSelected = false
    @State var seeAll = false
    @State var incomeValue = ""
    @State var expensesValue = ""
    @State var balance = ""
    
    var body: some View {
        NavigationStack(path: $store.transactions) {
            VStack {
                ScrollView {
                    BalanceComponentView(balance: $balance, income: $incomeValue, expense: $expensesValue)
                    FrequencyView()
                    RecentTransactionView(seeAll: $seeAll)
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
            .onReceive(viewModel.$incomeValue) { newValue in
                incomeValue = newValue
            }
            .onReceive(viewModel.$expensesValue) { newValue in
                expensesValue = newValue
            }
            .onReceive(viewModel.$balance) { newValue in
                balance = newValue
            }
            .navigationDestination(for: String.self, destination: { route in
                switch route {
                case "NewTransaction":
                    NewTransactionView(isIncome: $isIncome, balance: balance)
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
        HomeView(viewModel: Constants.transactionViewModel)
            .environmentObject(Store())
    }
}
