//
//  HomeView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            MonthSwitcherView()
            BalanceView(balance: "9400", income: "5000", expense: "1200")
            FrequencyView()
            
        }
    }
}

#Preview {
    HomeView()
}
