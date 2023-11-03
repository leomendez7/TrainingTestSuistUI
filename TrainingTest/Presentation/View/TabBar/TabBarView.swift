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
    @State var isIncome = Bool()
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "income"))) { _ in
                        isNewTransaction = true
                        isIncome = true
                    }
                    .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "expenses"))) { _ in
                        isNewTransaction = true
                        isIncome = false
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
                Text("Settings")
                    .tabItem {
                        Image("settings")
                        Text("Settings")
                    }
                    .tag(2)
            }
            .accentColor(.violet100)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isNewTransaction, destination: { NewTransactionView(isIncome: isIncome) })
        }
    }
}

#Preview {
    TabBarView()
}
