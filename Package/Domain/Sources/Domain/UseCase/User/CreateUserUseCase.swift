//
//  SaveUserUseCase.swift
//
//
//  Created by Leonardo Mendez on 10/11/23.
//

import Foundation

public class CreateUserUseCase: UseCaseProtocol {
    
    private let repository: UserRepositoryProtocol
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute(requestValue: User) async throws -> Bool {
        return try await repository.createUser(user: requestValue)
    }
    
}
