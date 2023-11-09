//
//  Default.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import Foundation
import SwiftUI

public class Default: ObservableObject {
    
    public enum Key: String {
        case onboarding
        case session
        case currency
        case security
    }
    
    @AppStorage("appStorageOnboarding") public var onboarding: Bool = false
    @AppStorage("appStorageSession") public var session: Bool = false
    
    public static func destroySession(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Key.session.rawValue)
        defaults.removeObject(forKey: Key.currency.rawValue)
        defaults.removeObject(forKey: Key.security.rawValue)
    }
    
    public init(onboarding: Bool, session: Bool) {
        self.onboarding = onboarding
        self.session = session
    }

}

