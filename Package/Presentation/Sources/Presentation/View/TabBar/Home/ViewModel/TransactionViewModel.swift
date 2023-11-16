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

public class TransactionViewModel: ObservableObject {
    
    var transactions: [Trade] = []
    var seeAll: Bool = false
    var selectedMont: String = ""
    @Published var images: [String] = []
    @Published var colors: [Color] = []
    @Published var months: [String] = []
    @Published var currentMonth: Int = 0
    
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
    
    func fetchTransactions() {
        guard let transactions = Default.user()?.trades else { return }
        var filterTransaction = [Trade]()
        self.transactions.removeAll()
        images.removeAll()
        colors.removeAll()
        transactions.forEach { trade in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM"
            let monthName = dateFormatter.string(from: trade.createDate)
            if monthName == selectedMont {
                filterTransaction.append(trade)
            }
        }
        if filterTransaction.count > 0 {
            var count = 0
            if filterTransaction.count < 3 {
                count = filterTransaction.count - 1
            } else {
                count = seeAll ? filterTransaction.count - 1 : 2
            }
            for index in 0...count {
                switch filterTransaction[index].category {
                case "Shopping":
                    images.append("shopping-bag")
                    colors.append(Color(.yellow20))
                case "Subscription":
                    images.append("recurring-bill")
                    colors.append(Color(.violet20))
                case "Food":
                    images.append("restaurant")
                    colors.append(Color(.red20))
                case "Salary":
                    images.append("salary")
                    colors.append(Color(.green20))
                default:
                    images.append("transportation")
                    colors.append(Color(.blue20))
                }
                self.transactions.append(filterTransaction[index])
            }
        }
    }
    
    func calculateValues() -> (String, String) {
        guard let transactions = Default.user()?.trades else { return ("0", "0") }
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
        return ("\(incomeValue)", "\(expensesValue)")
    }
    
}
