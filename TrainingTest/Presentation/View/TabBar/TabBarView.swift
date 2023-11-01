//
//  TabBarView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image("home")
                    Text("Home")
                }
                .tag(0)
            Text("Pestaña 2")
                .tabItem {
                    Image("transaction")
                    Text("Transaction")
                }
                .tag(1)
            Text("Pestaña 3")
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
}
