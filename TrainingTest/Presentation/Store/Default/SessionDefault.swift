//
//  SessionDefault.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import Foundation

extension Default {
    
    public static func session() -> Bool {
        let defaults = UserDefaults.standard
        guard let rawValue = defaults.object(forKey: Default.Key.session.rawValue) as? Bool else { return false }
        return rawValue
    }
    
    public static func save(session: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(session, forKey: Default.Key.session.rawValue)
    }
    
}
