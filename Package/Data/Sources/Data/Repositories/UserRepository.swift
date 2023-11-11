//
//  UserRepository.swift
//
//
//  Created by Leonardo Mendez on 10/11/23.
//

import Foundation
import Domain

public class UserRepository: UserRepositoryProtocol {
    
    let datasource: UserRepositoryDataSource
    
    public init(datasource: UserRepositoryDataSource) {
        self.datasource = datasource
    }
    
    public func fetchUser(email: String) async throws -> User {
        return try await self.datasource.fetchUser(email: email)
    }
    
    public func createUser(user: User) async throws -> Bool {
        return try await self.datasource.createUser(user: user)
    }
    
}
