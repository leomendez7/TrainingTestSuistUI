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
            print("Trade save successfully.")
            return true
        } catch {
            print("Document hasn't been save: \(error.localizedDescription)")
            return false
        }
    }
    
    public func fetchTransactions(email: String) async throws -> [Trade] {
        var trades: [Trade] = []
        let query = QueryBuilder
            .select(SelectResult.all())
            .from(DataSource.database(database))
            .where(Expression.property("email").equalTo(Expression.string(email)))
        do {
            for result in try query.execute() {
                if let document = result.dictionary(at: 0)?.toMutable(),
                   let jsonData = try? JSONSerialization.data(withJSONObject: document.toDictionary(), options: []),
                   let trade = try? JSONDecoder().decode(Trade.self, from: jsonData) {
                    print("Recovered trade: \(trade)")
                    trades.append(trade)
                }
            }
        } catch {
            print("Error querying trades: \(error.localizedDescription)")
            throw error
        }
        return trades
    }
    
    public func removeTransaction(trade: Trade) async throws -> Bool {
        do {
            let documentId = trade.id.uuidString
            let document = MutableDocument(id: documentId)
            try database.deleteDocument(document)
            print("Trade deleted successfully.")
            return true
        } catch {
            print("Trade not found for deletion.")
            return false
        }
    }
    
}
