//
//  TrainingTestApp.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 30/10/23.
//

import SwiftUI
import Presentation
import Domain
import Data

@main
struct TrainingTestApp: App {
   
    @StateObject var setDefault = Default()
    @StateObject var createUserViewModel =  generateCreateUserModule()
    @StateObject var loginViewModel = generateFetchUserModule()
    
    var body: some Scene {
        WindowGroup {
            let session = setDefault.session
            let onboarding = setDefault.onboarding
            if session && onboarding {
                TabBarView()
            } else if !session && !onboarding {
                OnboardingView()
            } else {
                LoginView()
                    .environmentObject(createUserViewModel)
                    .environmentObject(loginViewModel)
            }
        }
        .environmentObject(Store())
        .environmentObject(setDefault)
    }
    
    private static func generateCreateUserModule() -> CreateUserViewModel {
        let repository = UserRepository(datasource: UserRepositoryDataSource())
        let useCase = CreateUserUseCase(repository: repository)
        let userViewModel = CreateUserViewModel(useCase: useCase)
        return userViewModel
    }
    
    private static func generateFetchUserModule() -> LoginViewModel {
        let repository = UserRepository(datasource: UserRepositoryDataSource())
        let useCase = FetchUserUseCase(repository: repository)
        let loginViewModel = LoginViewModel(useCase: useCase)
        return loginViewModel
    }
    
}
