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

    @StateObject var setDefault = Default()
    
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
        .environmentObject(Store())
        .environmentObject(setDefault)
    }
    
}
