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
    
    var seeAll: Bool = false
    var selectedMont: String = ""
    var selectedFrequency: String = "Today"
    var allTransactions: [Trade] = []
    @Published var loading = true
    @Published var transactions: [Trade] = []
    @Published var frequencyTrades: [Trade] = []
    @Published var success: Bool = false
    @Published var images: [String] = []
    @Published var colors: [Color] = []
    @Published var months: [String] = []
    @Published var segments: [String] = []
    @Published var currentMonth: Int = 0
    @Published var incomeValue: String = ""
    @Published var expensesValue: String = ""
    @Published var balance: String = ""
    
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
    
    func generateSegments() {
        self.segments.removeAll()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        guard let selectedMonthDate = dateFormatter.date(from: self.selectedMont) else {
            return
        }
        let currentMonth = Calendar.current.component(.month, from: Date())
        let selectedMonth = Calendar.current.component(.month, from: selectedMonthDate)
        if currentMonth == selectedMonth {
            self.segments = ["Today", "Week", "Month", "Year"]
            selectedFrequency = "Today"
        } else {
            self.segments = ["Month", "Year"]
            selectedFrequency = "Month"
        }
    }
    
    func fetchTransactions() async {
        do {
            var response = try await useCase.execute(requestValue: Default.user()?.email ?? "")
            allTransactions.removeAll()
            allTransactions = response
            response = response.reversed()
            let transactions = response
            DispatchQueue.main.async {
                self.success = false
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
                        self.transactions.append(filterTransaction[index])
                    }
                }
                self.calculateBalance(transactions: transactions)
                self.calculateValues(transactions: filterTransaction)
                self.success = true
                self.loading = false
                self.spendFrequency()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func calculateValues(transactions: [Trade]) {
        var incomes = [Trade]()
        var expenses = [Trade]()
        var incomeValue = 0.0
        var expensesValue = 0.0
        incomes = transactions.filter { $0.isIncome == true }
        expenses = transactions.filter { $0.isIncome == false }
        incomes.forEach { trade in
            incomeValue = incomeValue + (Double(trade.value) ?? 0.0)
        }
        expenses.forEach { trade in
            expensesValue = expensesValue + (Double(trade.value) ?? 0.0)
        }
        let incomeDecimal = incomeValue.truncatingRemainder(dividingBy: 1)
        let expensesDecimal = expensesValue.truncatingRemainder(dividingBy: 1)
        self.incomeValue = incomeDecimal == 0 ? "\(Int(incomeValue))" : "\(incomeValue)"
        self.expensesValue = expensesDecimal == 0 ? "\(Int(expensesValue))" : "\(expensesValue)"
    }
    
    func calculateBalance(transactions: [Trade]) {
        var balance = 0.0
        transactions.forEach { trade in
            if trade.isIncome {
                balance = balance + (Double(trade.value) ?? 0.0)
            } else {
                balance = balance - (Double(trade.value) ?? 0.0)
            }
        }
        let balanceDecimal = balance.truncatingRemainder(dividingBy: 1)
        self.balance = balanceDecimal == 0 ? "\(Int(balance))" : "\(balance)"
    }
    
    func spendFrequency() {
        frequencyTrades.removeAll()
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        switch selectedFrequency {
        case "Today":
            frequencyTrades = allTransactions.filter { trade in
                let tradeDate = Calendar.current.startOfDay(for: trade.createDate)
                return tradeDate == today
            }
        case "Month":
            guard let monthIndex = months.firstIndex(of: selectedMont) else { return }
            let startDateComponents = DateComponents(year: calendar.component(.year, from: Date()), month: monthIndex + 1, day: 1)
            guard let startDateOfMonth = calendar.date(from: startDateComponents) else { return }
            guard let endDateOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDateOfMonth) else { return }
            frequencyTrades = allTransactions.filter { trade in
                let tradeDate = calendar.startOfDay(for: trade.createDate)
                return tradeDate >= startDateOfMonth && tradeDate <= endDateOfMonth
            }
        case "Year":
            guard let startDateOfYear = calendar.date(from: calendar.dateComponents([.year], from: today)) else { return }
            guard let endDateOfYear = calendar.date(byAdding: DateComponents(year: 1, day: -1), to: startDateOfYear) else { return }
            frequencyTrades = allTransactions.filter { trade in
                let tradeDate = calendar.startOfDay(for: trade.createDate)
                return tradeDate >= startDateOfYear && tradeDate <= endDateOfYear
            }
        default:
            guard let startDateOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else { return }
            guard let endDateOfWeek = calendar.date(byAdding: .day, value: 6, to: startDateOfWeek) else { return }
            frequencyTrades = allTransactions.filter { trade in
                let tradeDate = calendar.startOfDay(for: trade.createDate)
                return tradeDate >= startDateOfWeek && tradeDate <= endDateOfWeek
            }
        }
    }
    
}
