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
    
    func fetchTransactions() {
        transactions.removeAll()
        images.removeAll()
        colors.removeAll()
        let count = seeAll ? (Default.user()?.trades.count ?? 0) - 1 : 2
        for index in 0...count {
            switch Default.user()?.trades[index].category {
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
            transactions.append(Default.user()?.trades[index] ?? Trade())
        }
    }
    
}
