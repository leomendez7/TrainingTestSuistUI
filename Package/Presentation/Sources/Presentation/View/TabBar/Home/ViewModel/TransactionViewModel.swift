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
    
    @Published var transactions: [Domain.Transaction] = []
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
        }
    }
    
    func generateRandomTransaction() -> Domain.Transaction {
        let names = ["Shopping", "Subscription", "Food", "Salary", "Transportation"]
        let randomName = names.randomElement() ?? "Unknown"
        let randomDescription = generateRandomDescription()
        let randomHour = generateRandomHour()
        let randomValue = "\(Int.random(in: 1...500))"
        var transaction = Domain.Transaction()
        transaction.name = randomName
        transaction.description = randomDescription
        transaction.value = randomValue
        transaction.hour = randomHour
        return transaction
    }
    
    func generateRandomDescription() -> String {
        let alphabet = "abcdefghijklmnopqrstuvwxyz"
        let randomLength = Int.random(in: 1...10)
        let randomDescription = (0..<randomLength).map { _ in
            alphabet.randomElement()!
        }
        return String(randomDescription)
    }
    
    func generateRandomHour() -> String {
        let hours = ["06:00 AM", "07:00 AM", "08:00 AM", "09:00 AM",
                     "10:00 AM", "11:00 AM", "12:00 PM", "01:00 PM",
                     "02:00 PM", "03:00 PM", "04:00 PM", "05:00 PM",
                     "06:00 PM", "07:00 PM", "08:00 PM", "09:00 PM",
                     "10:00 PM", "11:00 PM", "11:59 PM"]
        return hours.randomElement() ?? "12:00 PM"
    }
    
    func fetchTransactions() {
        var transactions = [Domain.Transaction]()
        for _ in 0..<3 {
            let randomTransaction = generateRandomTransaction()
            switch randomTransaction.name {
            case "Shopping":
                images.append("shopping-bag")
                colors.append(Color("yellow-20", bundle: .module))
            case "Subscription":
                images.append("recurring-bill")
                colors.append(Color("violet-20", bundle: .module))
            case "Food":
                images.append("restaurant")
                colors.append(Color("red-20", bundle: .module))
            case "Salary":
                images.append("salary")
                colors.append(Color("green-20", bundle: .module))
            default:
                images.append("transportation")
                colors.append(Color("blue-20", bundle: .module))
            }
            transactions.append(randomTransaction)
        }
        self.transactions = transactions
    }
    
}
