//
//  File.swift
//  
//
//  Created by Leonardo Mendez on 17/11/23.
//

import Foundation
import Domain

public class TransactionDetailsViewModel: BaseViewModel<RemoveTransactionUseCase>, ObservableObject {
    
    var transaction = Trade()
    @Published var success: Bool = false
    
    func fetchTransactions() async {
        do {
            let response = try await useCase.execute(requestValue: transaction)
            DispatchQueue.main.async {
                self.success = response
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
