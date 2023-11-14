//
//  User.swift
//
//
//  Created by Leonardo Mendez on 10/11/23.
//

import Foundation

public struct User: Identifiable, Codable {
    
    public var id = UUID()
    public var name: String = ""
    public var email: String = ""
    public var birthday: String = ""
    public var password: String = ""
    
    public init() { }
    
    enum CodingKeys: String, CodingKey {
        case name
        case email
        case birthday
        case password
    }
    
}
