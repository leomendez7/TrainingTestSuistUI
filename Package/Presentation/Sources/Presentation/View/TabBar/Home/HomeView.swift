//
//  HomeView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: TransactionViewModel
    @EnvironmentObject var store: Store
    @State var isIncome = Bool()
    @State private var isSheetPresented = false
    
    var body: some View {
        NavigationStack(path: $store.transactions) {
            VStack {
                ScrollView {
                    BalanceComponentView(balance: "9400", income: "5000", expense: "1200")
                    FrequencyView()
                    RecentTransactionView()
                }
            }
            //.preferredColorScheme(.light)
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "income"))) { _ in
                isIncome = true
                store.transactions.append("NewTransaction")
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "expenses"))) { _ in
                isIncome = false
                store.transactions.append("NewTransaction")
            }
            .navigationDestination(for: String.self, destination: { route in
                switch route {
                case "NewTransaction":
                    NewTransactionView(isIncome: $isIncome)
                default:
                    EmptyView()
                }
            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Circle()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.white)
                        .overlay(
                            Image("avatar-2", bundle: .module)
                                .resizable()
                                .frame(width: 37, height: 37)
                        )
                }
                ToolbarItem(placement: .principal) {
                    MonthSwitcherView()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                         isSheetPresented.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(Color("violet-100", bundle: .module))
                    }
                    .sheet(isPresented: $isSheetPresented) {
                        NewOptionTransactionView(isSheetPresented: isSheetPresented)
                            .presentationDetents([.fraction(0.25)])
                    }
                }
            })
        }
    }
    
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(Store())
            .environmentObject(TransactionViewModel())
    }
}
