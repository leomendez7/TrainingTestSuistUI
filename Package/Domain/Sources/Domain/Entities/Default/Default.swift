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
        case user
        case currency
        case security
    }
    
    @AppStorage("appStorageOnboarding") public var onboarding = Bool()
    @AppStorage("appStorageSession") public var session = Bool()
    
    public static func destroySession(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Key.user.rawValue)
        defaults.removeObject(forKey: Key.currency.rawValue)
        defaults.removeObject(forKey: Key.security.rawValue)
    }
    
    public init() { }

}

