//
//  SettingsDefault.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import Foundation

extension Default {
    
    public static func currency() -> String {
        let defaults = UserDefaults.standard
        guard let rawValue = defaults.object(forKey: Default.Key.currency.rawValue) as? String else { return "USD" }
        return rawValue
    }
    
    public static func save(currency: String) {
        let defaults = UserDefaults.standard
        defaults.set(currency, forKey: Default.Key.currency.rawValue)
    }
    
    public static func security() -> String {
        let defaults = UserDefaults.standard
        guard let rawValue = defaults.object(forKey: Default.Key.security.rawValue) as? String else { return "PIN" }
        return rawValue
    }
    
    public static func save(security: String) {
        let defaults = UserDefaults.standard
        defaults.set(security, forKey: Default.Key.security.rawValue)
    }
    
}
