//
//  TrainingTestApp.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 30/10/23.
//

import SwiftUI
import Presentation

@main
struct TrainingTestApp: App {

    @ObservedObject var store = Store()
    @ObservedObject var setDefault = Default(onboarding: false, session: false)
    
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
            }
        }
        .environmentObject(store)
        .environmentObject(setDefault)
    }
    
}
