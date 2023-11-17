//
//  File.swift
//  
//
//  Created by Leonardo Mendez on 17/11/23.
//

import Foundation

public class RemoveTransactionUseCase: UseCaseProtocol {
    
    private let repository: TransactionRepositoryProtocol
    
    public init(repository: TransactionRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(requestValue: Trade) async throws -> Bool {
        return try await repository.removeTransaction(trade: requestValue)
    }
    
}
