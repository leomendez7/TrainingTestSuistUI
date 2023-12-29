//
//  File.swift
//  
//
//  Created by Leonardo Mendez on 14/11/23.
//

import Foundation

public class CreateTransactionUseCase: UseCaseProtocol {
    
    private let repository: TransactionRepositoryProtocol
    
    public init(repository: TransactionRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(requestValue: Trade) async throws -> Bool {
        return try await repository.createTransaction(trade: requestValue)
    }
    
}
