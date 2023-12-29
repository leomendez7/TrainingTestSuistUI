//
//  HomeView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI
import Domain

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var store: Store
    @State var isIncome = Bool()
    @State var isIncomeSelected = false
    @State var isExpensesSelected = false
    @State var isChangeMonth = false
    @State var seeAll = false
    @State var selectedTrade = Trade()
    @State var image = UIImage()
    @State private var isSheetPresented = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack(path: $store.transactions) {
            VStack {
                ScrollView {
                    BalanceComponentView(balance: viewModel.balance, income: viewModel.incomeValue, expense: viewModel.expensesValue)
                    FrequencyView()
                    RecentTransactionView(seeAll: $seeAll, selectedTrade: $selectedTrade)
                }
            }
            .preferredColorScheme(.light)
            .onAppear {
                viewModel.generateMonths()
                viewModel.generateSegments()
                viewModel.loading = true
                if let imageBase64 = Default.user()?.imageProfile {
                    if !imageBase64.isEmpty {
                        self.image = UIImage.fromBase64(imageBase64) ?? UIImage()
                    } else {
                       self.image = UIImage(named: "empty-user", in: .module, with: nil) ?? UIImage()
                    }
                }
                Task {
                    await viewModel.fetchTransactions()
                }
            }
            .onChange(of: isIncomeSelected) { _ in
                isIncome = true
                store.transactions.append("NewTransaction")
            }
            .onChange(of: isExpensesSelected) { _ in
                isIncome = false
                store.transactions.append("NewTransaction")
            }
            .onChange(of: seeAll) { _ in
                viewModel.seeAll = seeAll
                Task {
                    await viewModel.fetchTransactions()
                }
            }
            .onChange(of: isChangeMonth) { _ in
                viewModel.loading = true
                viewModel.generateSegments()
                Task {
                    await viewModel.fetchTransactions()
                }
            }
            .overlay(
                viewModel.loading ?
                ZStack {
                    Color.white.edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color(.violet100)))
                            .padding(20)
                        Spacer()
                    }
                }
                : nil
            )
            .navigationDestination(for: String.self, destination: { route in
                switch route {
                case "NewTransaction":
                    NewTransactionView(balance: viewModel.balance, isIncome: $isIncome)
                case "TransactionDetails":
                    TransactionDetailsView(selectedTrade: $selectedTrade, viewModel: Constants.transactionDetailsViewModel)
                default:
                    EmptyView()
                }
            })
            .homeTransactionToolbar(image: image,
                                    isSheetPresented: $isSheetPresented,
                                    incomeSelected: $isIncomeSelected,
                                    expensesSelected: $isExpensesSelected,
                                    months: $viewModel.months,
                                    currentMonth: $viewModel.currentMonth,
                                    selectedMont: $viewModel.selectedMont, 
                                    changeMonth: $isChangeMonth)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .environmentObject(viewModel)
        }
        .toolbarColorScheme(.light, for: .navigationBar)
    }
    
}

#Preview {
    NavigationStack {
        HomeView(viewModel: Constants.homeViewModel)
            .environmentObject(Store())
    }
}
