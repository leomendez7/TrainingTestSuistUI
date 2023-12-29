//
//  Security.swift
//
//
//  Created by Leonardo Mendez on 9/11/23.
//

import Foundation

public struct Security: Identifiable, Codable {
    
    public var id = UUID()
    public var name: SecurityName = .neither
    public var pin: String = ""
    
    public init() { }
    
    enum CodingKeys: String, CodingKey {
        case name
        case pin
    }
    
}

public enum SecurityName: String, Codable {
    case neither = "Neither"
    case pin = "PIN"
    case biometric = "Biometric Authentication"
}
