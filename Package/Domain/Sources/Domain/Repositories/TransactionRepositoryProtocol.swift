//
//  TransactionRepositoryProtocol.swift
//  
//
//  Created by Leonardo Mendez on 14/11/23.
//

import Foundation

public protocol TransactionRepositoryProtocol {
    
    //func fetchTransaction(credentials: [String: String]) async throws -> Trade
    func createTransaction(trade: Trade) async throws -> Bool
    
}
