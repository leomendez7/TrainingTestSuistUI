//
//  Transaction.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import Foundation

public struct Transaction: Identifiable, Codable {
    
    public var id = UUID()
    public var name: String = ""
    public var description: String = ""
    public var value: String = ""
    public var hour: String = ""
    
    public init() { }
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case value
        case hour = "date"
    }
    
}
