//
//  TransactionsViewModel.swift
//
//
//  Created by Leonardo Mendez on 17/11/23.
//

import Foundation
import Domain

public class TransactionsViewModel: BaseViewModel<FetchTransactionUseCase>, ObservableObject {
    
    @Published var transactions: [Trade] = []

    var groupedTransactions: [Date: [Trade]] {
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
        return groupedDict
    }

    func fetchTransactions() async {
        do {
            var response = try await useCase.execute(requestValue: Default.user()?.email ?? "")
            response = response.reversed()
            let transactions = response
            DispatchQueue.main.async {
                self.transactions.removeAll()
                transactions.forEach { trade in
                    self.transactions.append(trade)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

