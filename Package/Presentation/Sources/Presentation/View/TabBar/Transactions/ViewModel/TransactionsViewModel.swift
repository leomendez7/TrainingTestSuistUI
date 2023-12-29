//
//  TransactionsViewModel.swift
//
//
//  Created by Leonardo Mendez on 17/11/23.
//

import Foundation
import Domain

public class TransactionsViewModel: BaseViewModel<FetchTransactionUseCase>, ObservableObject {
    
    var store: Store
    var selectedMont: String = ""
    var activeFilter: Bool = false
    var activeSort: Bool = false
    var activeCategory: Bool = false
    var isIncome: Bool = false
    var isExpenses: Bool = false
    var isHighest: Bool = false
    var isLowest: Bool = false
    var isNewest: Bool = false
    var isOldest: Bool = false
    var filterCount: Int = 0
    var filters = 0
    var sorts = 0
    var categories = 0
    var selectedCategories: [CategoryName] = []
    @Published var groupedTransactions: [Date: [Trade]] = [:]
    @Published var loading = true
    @Published var currentMonth: Int = 0
    @Published var months: [String] = []
    var transactions: [Trade] = [] {
        didSet {
            updateGroupedTransactions()
        }
    }
    
    public init(useCase: FetchTransactionUseCase, store: Store) {
        self.store = store
        super.init(useCase: useCase)
    }
    
    func updateGroupedTransactions() {
        var groupedDict: [Date: [Trade]] = [:]
        var transactionSortFilter = [Trade]()
        if activeSort {
            transactionSortFilter = sort()
        } else {
            transactionSortFilter = transactions
        }
        if activeFilter {
            transactionSortFilter = transactionSortFilter.filter { trade in
                return (isIncome && trade.isIncome) || (isExpenses && !trade.isIncome)
            }
        }
        if activeCategory {
            transactionSortFilter = transactionSortFilter.filter { trade in
                return selectedCategories.contains(trade.category)
            }
        }
        for transaction in transactionSortFilter {
            let key = Calendar.current.startOfDay(for: transaction.createDate)
            if var existingTransactions = groupedDict[key] {
                existingTransactions.append(transaction)
                groupedDict[key] = existingTransactions
            } else {
                groupedDict[key] = [transaction]
            }
        }
        groupedTransactions = groupedDict
    }
    
    func sort() -> [Trade] {
        var transactions = [Trade]()
        transactions = self.transactions.sorted { (trade1, trade2) in
            let value1 = trade1.isIncome ? (Double(trade1.value) ?? 0) : -(Double(trade1.value) ?? 0)
            let value2 = trade2.isIncome ? (Double(trade2.value) ?? 0) : -(Double(trade2.value) ?? 0)
            if isHighest {
                return value1 > value2
            } else if isLowest {
                return value1 < value2
            } else if isNewest {
                return trade1.createDate > trade2.createDate
            } else if isOldest {
                return trade1.createDate < trade2.createDate
            } else {
                return false
            }
        }
        return transactions
    }
    
    func generateMonths() {
        let dateFormatter = DateFormatter()
        let months = dateFormatter.monthSymbols
        self.months.removeAll()
        self.months = months ?? [String]()
        if let currentMonth = Calendar.current.dateComponents([.month], from: Date()).month {
            self.currentMonth = currentMonth - 1
            dateFormatter.dateFormat = "MMMM"
            selectedMont = dateFormatter.string(from: Date())
        }
    }

    func fetchTransactions() async {
        do {
            var response = try await useCase.execute(requestValue: Default.user()?.email ?? "")
            response = response.reversed()
            let sortTransaction = response
            DispatchQueue.main.async {
                self.transactions.removeAll()
                var transactions = [Trade]()
                sortTransaction.forEach { trade in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MMMM"
                    let monthName = dateFormatter.string(from: trade.createDate)
                    if monthName == self.selectedMont {
                        transactions.append(trade)
                    }
                }
                self.transactions = transactions
                self.loading = false
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

