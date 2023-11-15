//
//  TransactionRepositoryDataSource.swift
//
//
//  Created by Leonardo Mendez on 14/11/23.
//

import Foundation
import Domain
import Shared
import CouchbaseLiteSwift

public class TransactionRepositoryDataSource {
    
    let database = try! Database(name: "Training")
    
    public init() { }
    
    public func createTransaction(trade: Trade) async throws -> Bool {
        do {
            let jsonData = trade.convertToJSON()
            let document = MutableDocument()
            document.setData(jsonData)
            try database.saveDocument(document)
            print("Document save successfully.")
            return true
        } catch {
            print("Document hasn't been save: \(error.localizedDescription)")
            return false
        }
    }
    
}
