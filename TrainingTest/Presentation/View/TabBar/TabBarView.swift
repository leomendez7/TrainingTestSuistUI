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
                        case "currency":
                            CurrencyView()
                                .environmentObject(CurrencyViewModel())
                        case "security":
                            CreateAccountView()
                        case "logout":
                            LoginView()
                        default:
                            EmptyView()
                        }
                    })
            }
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
