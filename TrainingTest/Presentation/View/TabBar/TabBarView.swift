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
            HomeView()
                .environmentObject(store)
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
            SettingsView()
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
