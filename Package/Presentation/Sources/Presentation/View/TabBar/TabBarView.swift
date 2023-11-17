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
    
    public init() {
        self.selectedTab = 0
        self.isNewTransaction = false
    }
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(viewModel: Constants.transactionViewModel)
                .tabItem {
                    Image("home", bundle: .module)
                    Text("Home")
                }
                .tag(0)
            TransactionsView(viewModel: Constants.transactionViewModel)
                .tabItem {
                    Image("transaction", bundle: .module)
                    Text("Transaction")
                }
                .tag(1)
            SettingsView()
                .environmentObject(CurrencyViewModel())
                .environmentObject(SecurityViewModel())
                .tabItem {
                    Image("settings", bundle: .module)
                    Text("Settings")
                }
                .tag(2)
        }
        .accentColor(Color(.violet100))
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TabBarView()
}
