//
//  UpdateUserUseCase.swift
//
//
//  Created by Leonardo Mendez on 14/11/23.
//

import Foundation

public class UpdateUserUseCase: UseCaseProtocol {
    
    private let repository: UserRepositoryProtocol
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(requestValue: User) async throws -> User {
        return try await repository.updateUser(user: requestValue)
    }
    
}
