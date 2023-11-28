//
//  NewTransactionViewModel.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import Foundation
import Combine
import SwiftUI
import Domain
import Shared

public class NewTransactionViewModel: BaseViewModel<CreateTransactionUseCase>, ObservableObject {
    
    var transaction = Trade()
    var balance = 0
    @Published var success: Bool = false
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
    private var store: Store
    private var cancellables: Set<AnyCancellable> = []
    
    public init(useCase: CreateTransactionUseCase, store: Store) {
        self.store = store
        super.init(useCase: useCase)
    }
    
    func showPhotoPicker() {
        if source == .camera {
            if !Picker.checkPermissions() {
                print("There is no camera on this device")
                return
            }
        }
        showPicker = true
    }
    
    func createTransaction(email: String,
                           category: String,
                           description: String,
                           payment: String,
                           value: String,
                           isIncome: Bool,
                           image: String,
                           balance: String,
                           date: Date) async {
        transaction.email = email
        transaction.category = category
        transaction.description = description
        transaction.payment = payment
        transaction.value = value
        transaction.isIncome = isIncome
        transaction.image = image
        transaction.createDate = date
        transaction.balanceLast = Double(balance) ?? 0.0
        if let balanceValue = Double(balance), let transactionValue = Double(value) {
            transaction.balanceLast = isIncome ? balanceValue + transactionValue : balanceValue - transactionValue
        }
        do {
            let response = try await useCase.execute(requestValue: transaction)
            DispatchQueue.main.async {
                self.success = response
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    
    func generateRandomTransactionsForCurrentMonth() {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentMonth = 11 //calendar.component(.month, from: currentDate)
        let currentYear = calendar.component(.year, from: currentDate)
        let currentDay = calendar.component(.day, from: currentDate)
        
        var transactions: [Trade] = []
        for day in 1...currentDay {
            let generateTradesPerDay = Int.random(in: 1...5)
            for _ in 1...generateTradesPerDay {
                guard let randomCategory = ["Shopping", "Subscription", "Food", "Salary", "Transportation"].randomElement(),
                      let randomDescription = ["Groceries", "Clothes", "Movie", "Electricity"].randomElement(),
                      let randomPayment = ["Wallet", "PayPal", "Chase"].randomElement() else {
                    continue
                }
                
                let randomValue = String(Int.random(in: 1...100))
                let isIncome = Bool.random()
                
                var transaction = Trade()
                transaction.email = Default.user()?.email ?? ""
                transaction.category = randomCategory
                transaction.description = randomDescription
                if ((isIncome == false) && ((Int(randomValue) ?? 0) > balance)) {
                    transaction.value = "\(Int(randomValue) ?? 0 - balance)"
                    transaction.isIncome = true
                } else {
                    transaction.value = randomValue
                    transaction.isIncome = isIncome
                }
                transaction.payment = randomPayment
                transaction.reminder = false
                transaction.createDate = createDateForDay(day: day, month: currentMonth, year: currentYear) ?? Date()
                
                balance = transaction.isIncome ? balance + (Int(transaction.value) ?? 0) : balance - (Int(transaction.value) ?? 0)
                transaction.balanceLast = Double(balance)
                print("Balance: \(balance)")
                transactions.append(transaction)
            }
        }
        
        for transaction in transactions {
            Task {
                await createTransaction(email: transaction.email,
                                        category: transaction.category,
                                        description: transaction.description,
                                        payment: transaction.payment,
                                        value: transaction.value,
                                        isIncome: transaction.isIncome,
                                        image: "",
                                        balance: "\(transaction.balanceLast)",
                                        date: transaction.createDate
                )
            }
        }
    }
    
    func createDateForDay(day: Int, month: Int, year: Int) -> Date? {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        return calendar.date(from: dateComponents)
    }
    
    
}
