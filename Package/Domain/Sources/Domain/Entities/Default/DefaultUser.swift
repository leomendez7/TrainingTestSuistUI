//
//  DefaultUser.swift
//
//
//  Created by Leonardo Mendez on 14/11/23.
//

import Foundation

extension Default {
    
    public static func user() -> User? {
        return User.current
    }
    
    public static func save(user: User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: Default.Key.user.rawValue)
        }
    }
    
}

extension User {
    
    public static var current: User? {
        let defaults = UserDefaults.standard
        if let savedUser = defaults.object(forKey: Default.Key.user.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let loadedJob = try? decoder.decode(User.self, from: savedUser) {
                return loadedJob
            }
        }
        return nil
    }
    
}
