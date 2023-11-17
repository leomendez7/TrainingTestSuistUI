//
//  transactionViewModel.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import Foundation
import Combine
import SwiftUI
import Domain

public class HomeViewModel: BaseViewModel<FetchTransactionUseCase>, ObservableObject {
    
    var transactions: [Trade] = []
    var seeAll: Bool = false
    var selectedMont: String = ""
    @Published var success: Bool = false
    @Published var images: [String] = []
    @Published var colors: [Color] = []
    @Published var months: [String] = []
    @Published var currentMonth: Int = 0
    @Published var incomeValue: String = ""
    @Published var expensesValue: String = ""
    @Published var balance: String = ""
    
    func generateMonths() {
        let dateFormatter = DateFormatter()
        let months = dateFormatter.monthSymbols
        self.months.removeAll()
        for index in 0...((months?.count ?? 0) - 1) {
            self.months.append(months?[index] ?? "")
        }
        if let currentMonth = Calendar.current.dateComponents([.month], from: Date()).month {
            self.currentMonth = currentMonth - 1
            dateFormatter.dateFormat = "MMMM"
            selectedMont = dateFormatter.string(from: Date())
        }
    }
    
    func fetchTransactions() async {
        do{
            let transactions = try await useCase.execute(requestValue: Default.user()?.email ?? "")
            DispatchQueue.main.async {
                var filterTransaction = [Trade]()
                self.transactions.removeAll()
                self.images.removeAll()
                self.colors.removeAll()
                transactions.forEach { trade in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MMMM"
                    let monthName = dateFormatter.string(from: trade.createDate)
                    if monthName == self.selectedMont {
                        filterTransaction.append(trade)
                    }
                }
                if filterTransaction.count > 0 {
                    var count = 0
                    if filterTransaction.count < 3 {
                        count = filterTransaction.count - 1
                    } else {
                        count = self.seeAll ? filterTransaction.count - 1 : 2
                    }
                    for index in 0...count {
                        switch filterTransaction[index].category {
                        case "Shopping":
                            self.images.append("shopping-bag")
                            self.colors.append(Color(.yellow20))
                        case "Subscription":
                            self.images.append("recurring-bill")
                            self.colors.append(Color(.violet20))
                        case "Food":
                            self.images.append("restaurant")
                            self.colors.append(Color(.red20))
                        case "Salary":
                            self.images.append("salary")
                            self.colors.append(Color(.green20))
                        default:
                            self.images.append("transportation")
                            self.colors.append(Color(.blue20))
                        }
                        self.transactions.append(filterTransaction[index])
                    }
                }
                self.calculateBalance(transactions: transactions)
                self.calculateValues(transactions: filterTransaction)
                self.success = true
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func calculateValues(transactions: [Trade]) {
        var incomes = [Trade]()
        var expenses = [Trade]()
        var incomeValue = 0
        var expensesValue = 0
        incomes = transactions.filter { $0.isIncome == true }
        expenses = transactions.filter { $0.isIncome == false }
        incomes.forEach { trade in
            incomeValue = incomeValue + (Int(trade.value) ?? 0)
        }
        expenses.forEach { trade in
            expensesValue = expensesValue + (Int(trade.value) ?? 0)
        }
        self.incomeValue = "\(incomeValue)"
        self.expensesValue = "\(expensesValue)"
    }
    
    func calculateBalance(transactions: [Trade]) {
        var balance = 0
        transactions.forEach { trade in
            if trade.isIncome {
                balance = balance + (Int(trade.value) ?? 0)
            } else {
                balance = balance - (Int(trade.value) ?? 0)
            }
        }
        self.balance = "\(balance)"
    }
    
}
