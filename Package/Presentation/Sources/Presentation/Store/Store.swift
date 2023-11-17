//
//  Store.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 3/11/23.
//

import SwiftUI

public class Store: ObservableObject {
    
    @Published public var onboarding = NavigationPath()
    @Published public var login = NavigationPath()
    @Published public var transactions = NavigationPath()
    @Published public var settings = NavigationPath()
    
    public static var storeDefault = Store()
    
    public init(onboarding: NavigationPath = NavigationPath(), 
                login: NavigationPath = NavigationPath(),
                transactions: NavigationPath = NavigationPath(),
                settings: NavigationPath = NavigationPath()) {
        self.onboarding = onboarding
        self.login = login
        self.transactions = transactions
        self.settings = settings
    }
}
