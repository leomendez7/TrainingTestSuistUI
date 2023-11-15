//
//  Transaction.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import Foundation

public struct Trade: Identifiable, Codable {
    
    public var id = UUID()
    public var name: String = ""
    public var description: String = ""
    public var value: String = ""
    public var isIncome: Bool = false
    public var pay: String = ""
    public var reminder: Bool = false
    public var date = Date()
    
    public init() { }
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case value
        case isIncome
        case pay
        case reminder
        case date
    }
    
}
