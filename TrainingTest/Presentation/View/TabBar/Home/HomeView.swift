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
            store.transactions.append("NewIncomeTransaction")
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "expenses"))) { _ in
            isIncome = false
            store.transactions.append("NewExpensesTransaction")
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(Store())
}
