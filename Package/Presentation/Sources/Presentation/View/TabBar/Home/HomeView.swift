//
//  HomeView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: TransactionViewModel
    @EnvironmentObject var store: Store
    @State var isIncome = Bool()
    @State private var isSheetPresented = false
    @State var isIncomeSelected = false
    @State var isExpensesSelected = false
    @State var seeAll = false
    @State var incomeValue = ""
    @State var expensesValue = ""
    
    var body: some View {
        NavigationStack(path: $store.transactions) {
            VStack {
                ScrollView {
                    BalanceComponentView(balance: "9400", income: $incomeValue, expense: $expensesValue)
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
                viewModel.fetchTransactions()
            }
            .onAppear {
                incomeValue = viewModel.calculateValues().0
                expensesValue = viewModel.calculateValues().1
            }
            .navigationDestination(for: String.self, destination: { route in
                switch route {
                case "NewTransaction":
                    NewTransactionView(isIncome: $isIncome)
                default:
                    EmptyView()
                }
            })
            .homeTransactionToolbar(image: "avatar-2", isSheetPresented: $isSheetPresented, incomeSelected: $isIncomeSelected, expensesSelected: $isExpensesSelected)
        }
    }
    
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(Store())
            .environmentObject(TransactionViewModel())
    }
}
