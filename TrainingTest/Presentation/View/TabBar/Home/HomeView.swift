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
                store.transactions.append("NewIncomeTransaction")
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "expenses"))) { _ in
                isIncome = false
                store.transactions.append("NewExpensesTransaction")
            }
            .navigationDestination(for: String.self, destination: { route in
                switch route {
                case "NewIncomeTransaction":
                    NewTransactionView(isIncome: $isIncome)
                        .environmentObject(TransactionViewModel())
                case "NewExpensesTransaction":
                    NewTransactionView(isIncome: $isIncome)
                        .environmentObject(TransactionViewModel())
                default:
                    EmptyView()
                }
            })
            //        .toolbar(content: {
            //            ToolbarItem(placement: .topBarLeading) {
            //                Text("izq")
            //            }
            //            ToolbarItem(placement: .topBarTrailing) {
            //                Text("izq")
            //            }
            //            ToolbarItem(placement: .principal) {
            //                Button(action: {
            //                   // isSheetPresented.toggle()
            //                }) {
            //                    Image(systemName: "plus.circle.fill")
            //                        .resizable()
            //                        .frame(width: 35, height: 35)
            //                        .foregroundColor(.violet100)
            //                }
            //            }
            //        })
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(Store())
}
