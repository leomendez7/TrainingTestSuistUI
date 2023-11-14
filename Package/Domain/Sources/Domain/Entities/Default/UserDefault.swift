//
//  UserDefault.swift
//
//
//  Created by Leonardo Mendez on 14/11/23.
//

import Foundation

extension Default {
    
    public static func user() -> User {
        let defaults = UserDefaults.standard
        guard let data = defaults.data(forKey: Default.Key.user.rawValue) else { return User() }
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(User.self, from: data)
            return model
        } catch {
            print("Error decoding Currency: \(error.localizedDescription)")
            return User()
        }
    }
    
    public static func save(user: User) {
        let defaults = UserDefaults.standard
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)
            defaults.set(data, forKey: Default.Key.user.rawValue)
        } catch {
            print("Error encoding Currency: \(error.localizedDescription)")
        }
    }
    
}
