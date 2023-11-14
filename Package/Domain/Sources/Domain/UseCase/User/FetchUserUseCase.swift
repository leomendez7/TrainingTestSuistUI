//
//  FetchUserUseCase.swift
//
//
//  Created by Leonardo Mendez on 13/11/23.
//

import Foundation

public class FetchUserUseCase: UseCaseProtocol {
    
    private let repository: UserRepositoryProtocol
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(requestValue: [String: String]) async throws -> User {
        return try await repository.fetchUser(credentials: requestValue)
    }
    
}
