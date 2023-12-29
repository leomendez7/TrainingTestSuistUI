//
//  FetchTransactionUseCase.swift
//
//
//  Created by Leonardo Mendez on 16/11/23.
//

import Foundation

public class FetchTransactionUseCase: UseCaseProtocol {
    
    private let repository: TransactionRepositoryProtocol
    
    public init(repository: TransactionRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(requestValue: String) async throws -> [Trade] {
        return try await repository.fetchTransaction(email: requestValue)
    }
    
}
