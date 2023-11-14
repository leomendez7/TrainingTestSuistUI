//
//  UserRepositoryProtocol.swift
//
//
//  Created by Leonardo Mendez on 10/11/23.
//

import Foundation

public protocol UserRepositoryProtocol {
    
    func fetchUser(credentials: [String: String]) async throws -> User
    func createUser(user: User) async throws -> Bool
    func updateUser(user: User) async throws -> User
    
}
