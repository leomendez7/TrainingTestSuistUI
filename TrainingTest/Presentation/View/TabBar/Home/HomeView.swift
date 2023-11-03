//
//  HomeView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var transactionViewModel = TransactionViewModel()
    @EnvironmentObject var store: Store
    @State var isIncome = Bool()
    
    var body: some View {
        NavigationStack(path: $store.transactions) {
            VStack {
                MonthSwitcherView()
                ScrollView {
                    BalanceComponentView(balance: "9400", income: "5000", expense: "1200")
                    FrequencyView()
                    RecentTransactionView(viewModel: transactionViewModel)
                }
                //        .environmentObject(transactionViewModel)
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "income"))) { _ in
                isIncome = true
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "expenses"))) { _ in
                isIncome = false
            }
            .navigationDestination(for: String.self, destination: { route in
                switch route {
                case "NewIncomeTransaction":
                    //isIncome = true
                    NewTransactionView(isIncome: $isIncome)
                case "NewExpensesTransaction":
                    //isIncome = false
                    NewTransactionView(isIncome: $isIncome)
                default:
                    EmptyView()
                }
            })
        }
    }
}

#Preview {
    HomeView()
}
