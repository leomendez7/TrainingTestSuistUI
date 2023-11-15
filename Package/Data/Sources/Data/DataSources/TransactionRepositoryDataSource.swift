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
        let email = Default.user()?.email ?? ""
        let query = QueryBuilder
            .select(SelectResult.all())
            .from(DataSource.database(database))
            .where(Expression.property("email").equalTo(Expression.string(email)))
        do {
            for result in try query.execute() {
                guard let dictionary = result.dictionary(at: 0)?.toMutable() else {
                    print("Error: No user dictionary found.")
                    return false
                }
                do {
                    var user = try JSONDecoder().decode(User.self, from: JSONSerialization.data(withJSONObject: dictionary.toDictionary() , options: []))
                    Default.user()?.trades.forEach { trade in
                        user.trades.append(trade)
                    }
                    user.trades.append(trade)
                    Default.save(user: user)
                    let updatedDocument = MutableDocument(id: dictionary.string(forKey: "_id"))
                    updatedDocument.setData(user.convertToJSON())
                    try database.saveDocument(updatedDocument)
                    print("Trade added to user successfully.")
                    return true
                } catch {
                    print("Error decoding user: \(error.localizedDescription)")
                    return false
                }
            }
        } catch {
            print("Document hasn't been save: \(error.localizedDescription)")
            return false
        }
        return false
    }
    
}
