//
//  Default.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import Foundation

public struct Default {
    
    public enum Key: String {
        case onboarding
        case session
    }
    
    public static func destroySession(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: Key.session.rawValue)
    }

}

