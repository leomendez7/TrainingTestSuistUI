//
//  TransactionRepository.swift
//  
//
//  Created by Leonardo Mendez on 14/11/23.
//

import Foundation
import Domain

public class TransactionRepository: TransactionRepositoryProtocol {
    
    let datasource: TransactionRepositoryDataSource
    
    public init(datasource: TransactionRepositoryDataSource) {
        self.datasource = datasource
    }
    
    public func createTransaction(trade: Trade) async throws -> Bool {
        return try await self.datasource.createTransaction(trade: trade)
    }
    
    public func fetchTransaction(email: String) async throws -> [Trade] {
        return try await self.datasource.fetchTransactions(email: email)
    }
}
