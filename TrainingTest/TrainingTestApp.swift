//
//  TrainingTestApp.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 30/10/23.
//

import SwiftUI
import Presentation
import Domain

@main
struct TrainingTestApp: App {
    
    @StateObject var setDefault = DefaultSession()
    
    var body: some Scene {
        WindowGroup {
            let session = setDefault.session
            let onboarding = setDefault.onboarding
            if session && onboarding {
                if let security = Default.security {
                    switch security.name {
                    case "PIN":
                        TabBarView()
                    case "Biometric Authentication":
                        AuthenticationErrorView()
                    default:
                        TabBarView()
                    }
                } else {
                    TabBarView()
                }
            } else if !session && !onboarding {
                OnboardingView()
            } else {
                LoginView(viewModel: Constants.loginViewModel)
            }
        }
        .environmentObject(Store.storeDefault)
        .environmentObject(setDefault)
    }
    
}
