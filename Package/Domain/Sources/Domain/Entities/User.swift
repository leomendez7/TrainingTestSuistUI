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
    public var lastName: String = ""
    public var email: String = ""
    public var birthday: Date = Date()
    
    public init() { }
    
    enum CodingKeys: String, CodingKey {
        case name
        case lastName
        case email
        case birthday
    }
    
}
