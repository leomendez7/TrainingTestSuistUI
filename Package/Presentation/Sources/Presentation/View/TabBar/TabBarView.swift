//
//  TabBarView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

public struct TabBarView: View {
    
    @State private var selectedTab = 0
    @State private var isNewTransaction = false
    @EnvironmentObject var store: Store
    @StateObject var transactionViewModel = TransactionViewModel()
    @StateObject var currencyViewModel = CurrencyViewModel()
    
    public init() {
        self.selectedTab = 0
        self.isNewTransaction = false
    }
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .environmentObject(transactionViewModel)
                .tabItem {
                    Image("home", bundle: .module)
                    Text("Home")
                }
                .tag(0)
            Text("Transactions")
                .tabItem {
                    Image("transaction", bundle: .module)
                    Text("Transaction")
                }
                .tag(1)
            SettingsView()
                .environmentObject(currencyViewModel)
                .tabItem {
                    Image("settings", bundle: .module)
                    Text("Settings")
                }
                .tag(2)
        }
        .accentColor(Color("violet-100", bundle: .module))
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TabBarView()
        .environmentObject(Store())
}
