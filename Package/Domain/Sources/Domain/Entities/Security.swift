//
//  Security.swift
//
//
//  Created by Leonardo Mendez on 9/11/23.
//

import Foundation

public struct Security: Identifiable, Codable {
    
    public var id = UUID()
    public var name: String = ""
    
    public init() { }
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
}
