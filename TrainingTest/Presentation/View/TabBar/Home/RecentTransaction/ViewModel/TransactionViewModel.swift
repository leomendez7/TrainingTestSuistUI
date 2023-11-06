//
//  transactionViewModel.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import Foundation
import Combine
import SwiftUI

public class TransactionViewModel: ObservableObject {
    
    @Published var transactions: [Transaction] = []
    @Published var images: [String] = []
    @Published var colors: [Color] = []
    
    
    func generateRandomTransaction() -> Transaction {
        let names = ["Shopping", "Subscription", "Food", "Salary", "Transportation"]
        let randomName = names.randomElement() ?? "Unknown"
        let randomDescription = generateRandomDescription()
        let randomHour = generateRandomHour()
        let randomValue = "\(Int.random(in: 1...500))"
        return Transaction(id: UUID(), name: randomName,
                           description: randomDescription,
                           value: randomValue,
                           hour: randomHour)
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
        var transactions = [Transaction]()
        for _ in 0..<3 {
            let randomTransaction = generateRandomTransaction()
            switch randomTransaction.name {
            case "Shopping":
                images.append("shopping-bag")
                colors.append(.yellow20)
            case "Subscription":
                images.append("recurring-bill")
                colors.append(.violet20)
            case "Food":
                images.append("restaurant")
                colors.append(.red20)
            case "Salary":
                images.append("salary")
                colors.append(.green20)
            default:
                images.append("transportation")
                colors.append(.blue20)
            }
            transactions.append(randomTransaction)
        }
        self.transactions = transactions
    }
    
}
