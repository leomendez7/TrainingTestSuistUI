//
//  TabBarView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab = 0
    @State private var isNewTransaction = false
    @EnvironmentObject var store: Store
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack(path: $store.transactions) {
                HomeView()
                    .navigationDestination(for: String.self, destination: { route in
                        switch route {
                        case "NewIncomeTransaction":
                            NewTransactionView(isIncome: .constant(true))
                                .environmentObject(TransactionViewModel())
                        case "NewExpensesTransaction":
                            NewTransactionView(isIncome: .constant(false))
                                .environmentObject(TransactionViewModel())
                        default:
                            EmptyView()
                        }
                    })
                    .environmentObject(store)
            }
            .tabItem {
                Image("home")
                Text("Home")
            }
            .tag(0)
            Text("Transactions")
                .tabItem {
                    Image("transaction")
                    Text("Transaction")
                }
                .tag(1)
            NavigationStack(path: $store.settings) {
                SettingsView()
                    .navigationDestination(for: String.self, destination: { route in
                        switch route {
                        case "Currency":
                            CurrencyView()
                                .environmentObject(CurrencyViewModel())
                        case "Security":
                            CreateAccountView()
                        case "Logout":
                            LoginView()
                        default:
                            EmptyView()
                        }
                    })
            }
            .environmentObject(store)
            .tabItem {
                Image("settings")
                Text("Settings")
            }
            .tag(2)
        }
        .accentColor(.violet100)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TabBarView()
        .environmentObject(Store())
}
