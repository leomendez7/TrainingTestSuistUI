//
//  TransactionFilterView.swift
//  
//
//  Created by Leonardo Mendez on 28/11/23.
//

import SwiftUI

struct TransactionFilterView: View {
    
    @State var filter = 0
    @State var sort = 0
    @State var category = 0
    @State var reset: Bool = false
    @State var filterApply: Bool = false
    @State var filterCount = 0
    @Binding var totalFilter: Int
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: TransactionsViewModel
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationStack(path: $store.category) {
            VStack(spacing: 16) {
                Image("line", bundle: .module)
                    .padding(.top, 16)
                HStack {
                    Text("Filter Transaction")
                        .textModifierStyle(size: 16, color: Color(.dark), weight: .semibold)
                    Spacer()
                    CustomButton(action: {
                        filterReset()
                    }, text: "Reset",
                                 color: Color(.violet20),
                                 foregroundColor: Color(.violet100),
                                 height: 32,
                                 width: 71,
                                 fontSize: 16,
                                 fontWeight: .regular)
                }
                FilterByView(filterCount: $filter, reset: $reset)
                SortByView(filterCount: $sort, reset: $reset)
                CategoryByView(reset: $reset, viewModel: viewModel)
                Spacer()
                CustomButton(action: {
                    filterApply = true
                    Task {
                        await viewModel.fetchTransactions()
                    }
                    totalFilter = viewModel.filterCount
                    dismiss()
                }, text: "Apply", color: Color(.violet100), foregroundColor: .white)
                
            }
            .padding(.horizontal, 16)
            .onAppear {
                filter = viewModel.filters
                sort = viewModel.sorts
                category = viewModel.categories
            }
            .onChange(of: filter) { _ in
                if viewModel.filterCount < 3 && (filter > 0 && filter == 1) {
                    viewModel.filterCount += 1
                    viewModel.filters += 1
                }
            }
            .onChange(of: sort) { _ in
                if viewModel.filterCount < 3 && (sort > 0 && sort == 1) {
                    viewModel.filterCount += 1
                    viewModel.sorts += 1
                }
            }
            .onChange(of: category) { _ in
                if viewModel.filterCount < 3 && (category > 0 && category == 1) {
                    viewModel.filterCount += 1
                    viewModel.categories += 1
                }
            }
            .navigationDestination(for: String.self, destination: { route in
                switch route {
                case "SelectCategory":
                    SelectCategoryView(viewModel: viewModel, filterCount: $category)
                default:
                    EmptyView()
                }
            })
        }
    }
    
    func filterReset() {
        filter = 0
        sort = 0
        category = 0
        totalFilter = 0
        viewModel.filterCount = 0
        viewModel.filters = 0
        viewModel.sorts = 0
        viewModel.categories = 0
        viewModel.activeFilter = false
        viewModel.activeSort = false
        viewModel.activeCategory = false
        viewModel.isIncome = false
        viewModel.isExpenses = false
        viewModel.isHighest = false
        viewModel.isLowest = false
        viewModel.isNewest = false
        viewModel.isOldest = false
        reset.toggle()
        Task {
            await viewModel.fetchTransactions()
        }
    }
    
}

#Preview {
    TransactionFilterView(totalFilter: .constant(1))
        .environmentObject(Constants.transactionViewModel)
        .environmentObject(Store())
}
