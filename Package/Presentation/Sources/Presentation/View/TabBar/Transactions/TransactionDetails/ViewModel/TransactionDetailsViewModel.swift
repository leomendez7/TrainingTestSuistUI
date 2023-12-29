//
//  File.swift
//  
//
//  Created by Leonardo Mendez on 17/11/23.
//

import Foundation
import Domain
import Combine

public class TransactionDetailsViewModel: BaseViewModel<RemoveTransactionUseCase>, ObservableObject {
    
    @Published var success: Bool = false
    private var store: Store
    private var cancellables: Set<AnyCancellable> = []
    
    public init(useCase: RemoveTransactionUseCase, store: Store) {
        self.store = store
        super.init(useCase: useCase)
        self.subscribe()
    }
    
    func removeTransactions(trade: Trade) async {
        do {
            let response = try await useCase.execute(requestValue: trade)
            DispatchQueue.main.async {
                self.success = response
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func subscribe() {
        $success.sink { response in
            if response {
                self.store.transactions.removeLast()
            }
        }.store(in: &cancellables)
    }
    
}
