//
//  UserRepositoryDataSource.swift
//
//
//  Created by Leonardo Mendez on 10/11/23.
//

import Foundation
import Domain
import Shared
import CouchbaseLiteSwift

public class UserRepositoryDataSource {
    
    let database = try! Database(name: "Training")
    
    public init() { }
    
    public func createUser(user: User) async throws -> Bool {
        do {
            let jsonData = user.convertToJSON()
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
    
    public func fetchUser(credentials: [String: String]) async throws -> User {
        let query = QueryBuilder
            .select(SelectResult.all())
            .from(DataSource.database(database))
            .where(Expression.property("email").equalTo(Expression.string(credentials["email"]))
                .and(Expression.property("password").equalTo(Expression.string(credentials["password"]))))
        do {
            for result in try query.execute() {
                if let document = result.dictionary(at: 0)?.toMutable() {
                    if let jsonData = try? JSONSerialization.data(withJSONObject: document.toDictionary(), options: []), 
                        let user = try? JSONDecoder().decode(User.self, from: jsonData) {
                        print("Recovered user: \(user)")
                        return user
                    }
                }
            }
        } catch {
            print("Error to query: \(error.localizedDescription)")
            throw error
        }
        return User()
    }
    
    public func updateUser(user: User) async throws -> User {
        let query = QueryBuilder
            .select(SelectResult.all())
            .from(DataSource.database(database))
            .where(Expression.property("email").equalTo(Expression.string(user.email)))
        do {
            for result in try query.execute() {
                if let dictionary = result.dictionary(at: 0)?.toMutable() {
                    let updatedDocument = MutableDocument(id: dictionary.string(forKey: "_id"))
                    updatedDocument.setData(dictionary.toDictionary())
                    updatedDocument.setBoolean(true, forKey: "isUpdated")
                    try database.saveDocument(updatedDocument)
                    print("Document updated successfully.")
                    return user
                }
            }
        } catch {
            print("Error updating document: \(error.localizedDescription)")
            throw error
        }
        print("Document not found for update.")
        return User()
    }
    
}
