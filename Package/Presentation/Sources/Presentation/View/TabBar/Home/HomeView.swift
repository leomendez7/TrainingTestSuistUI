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
    
    var body: some View {
        NavigationStack(path: $store.transactions) {
            VStack {
                ScrollView {
                    BalanceComponentView(balance: "9400", income: "5000", expense: "1200")
                    FrequencyView()
                    RecentTransactionView()
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
            .navigationDestination(for: String.self, destination: { route in
                switch route {
                case "NewTransaction":
                    NewTransactionView(isIncome: $isIncome)
                default:
                    EmptyView()
                }
            })
            .addToolbar(image: "avatar-2", isSheetPresented: $isSheetPresented, incomeSelected: $isIncomeSelected, expensesSelected: $isExpensesSelected)
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
