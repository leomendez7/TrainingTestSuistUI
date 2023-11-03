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

    @State var store = Store()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }.environmentObject(store)
    }
    
}
