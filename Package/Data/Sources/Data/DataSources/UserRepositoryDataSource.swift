//
//  UserRepositoryDataSource.swift
//
//
//  Created by Leonardo Mendez on 10/11/23.
//

import Foundation
import Domain
import CouchbaseLiteWrapper

public class UserRepositoryDataSource {
    
    let couchBaseDatabase = CouchbaseDatabase(databaseName: "User")
    
    public func createUser(user: User) async throws -> Bool {
        let attributes = ["name": user.name, 
                          "last_name": user.lastName,
                          "email": user.email,
                          "birthday": user.birthday] as [String: Any]
        let document = CouchbaseDocument(id: "\(user.id)", attributes: attributes)
        couchBaseDatabase.save(document)
        return true
    }
    
    public func fetchUser(email: String) async throws -> User {
//        let expression = Expresion
//        let documents = couchbaseDatabase.fetchAll(whereExpression: expression)
        let user = User()
        return user
    }
    
}
