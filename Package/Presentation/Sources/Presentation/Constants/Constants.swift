//
//  File.swift
//  
//
//  Created by Leonardo Mendez on 16/11/23.
//

import Foundation
import Domain
import Data

public class Constants {
    
    public static var loginViewModel = generateFetchUserModule()
    static var editProfileViewModel = generateUpdateUserModule()
    static var newTransactionViewModel = generateCreateTransactionModule()
    static var transactionViewModel = generateHomeModule()
    static var createUserViewModel =  generateCreateUserModule()
    
    private static func generateCreateUserModule() -> CreateUserViewModel {
        let repository = UserRepository(datasource: UserRepositoryDataSource())
        let useCase = CreateUserUseCase(repository: repository)
        let userViewModel = CreateUserViewModel(useCase: useCase, store: Store.storeDefault)
        return userViewModel
    }
    
    private static func generateFetchUserModule() -> LoginViewModel {
        let repository = UserRepository(datasource: UserRepositoryDataSource())
        let useCase = FetchUserUseCase(repository: repository)
        let loginViewModel = LoginViewModel(useCase: useCase)
        return loginViewModel
    }
    
    private static func generateUpdateUserModule() -> EditProfileViewModel {
        let repository = UserRepository(datasource: UserRepositoryDataSource())
        let useCase = UpdateUserUseCase(repository: repository)
        let editProfileViewModel = EditProfileViewModel(useCase: useCase)
        return editProfileViewModel
    }
    
    private static func generateCreateTransactionModule() -> NewTransactionViewModel {
        let repository = TransactionRepository(datasource: TransactionRepositoryDataSource())
        let useCase = CreateTransactionUseCase(repository: repository)
        let newTransactionViewModel = NewTransactionViewModel(useCase: useCase, store: Store.storeDefault)
        return newTransactionViewModel
    }
    
    private static func generateHomeModule() -> HomeViewModel {
        let repository = TransactionRepository(datasource: TransactionRepositoryDataSource())
        let useCase = FetchTransactionUseCase(repository: repository)
        let transactionViewModel = HomeViewModel(useCase: useCase)
        return transactionViewModel
    }
    
}
