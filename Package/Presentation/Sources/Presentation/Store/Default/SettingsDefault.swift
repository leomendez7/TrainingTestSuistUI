//
//  SettingsDefault.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import Foundation
import Domain

extension Default {
    
    public static func currency() -> Currency {
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: Default.Key.currency.rawValue) else { return Currency() }
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(Currency.self, from: data)
            return model
        } catch {
            print("Error decoding Currency: \(error.localizedDescription)")
            return Currency()
        }
    }
    
    public static func save(currency: Currency) {
        let defaults = UserDefaults.standard
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(currency)
            defaults.set(data, forKey: Default.Key.currency.rawValue)
        } catch {
            print("Error encoding Currency: \(error.localizedDescription)")
        }
    }
    
    public static func security() -> Security {
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: Default.Key.security.rawValue) else { return Security() }
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(Security.self, from: data)
            return model
        } catch {
            print("Error decoding Security: \(error.localizedDescription)")
            return Security()
        }
    }
    
    public static func save(security: Security) {
        let defaults = UserDefaults.standard
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(security)
            defaults.set(data, forKey: Default.Key.security.rawValue)
        } catch {
            print("Error encoding Security: \(error.localizedDescription)")
        }
    }
    
}
