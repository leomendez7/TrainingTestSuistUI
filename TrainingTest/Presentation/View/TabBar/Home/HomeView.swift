//
//  HomeView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var transactionViewModel = TransactionViewModel()
    
    var body: some View {
        ScrollView {
            MonthSwitcherView()
            BalanceComponentView(balance: "9400", income: "5000", expense: "1200")
            FrequencyView()
            RecentTransactionView(viewModel: transactionViewModel)
        }
        //        .environmentObject(transactionViewModel)
    }
}

#Preview {
    HomeView()
}
