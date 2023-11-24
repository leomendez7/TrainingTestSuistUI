//
//  TransactionsViewModel.swift
//
//
//  Created by Leonardo Mendez on 17/11/23.
//

import Foundation
import Domain

public class TransactionsViewModel: BaseViewModel<FetchTransactionUseCase>, ObservableObject {
    
    var selectedMont: String = ""
    @Published var groupedTransactions: [Date: [Trade]] = [:]
    @Published var loading = true
    @Published var currentMonth: Int = 0
    @Published var months: [String] = []
    var transactions: [Trade] = [] {
        didSet {
            updateGroupedTransactions()
        }
    }
    
    private func updateGroupedTransactions() {
        var groupedDict: [Date: [Trade]] = [:]
        for transaction in transactions {
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
            let sortTransaction =  response
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

