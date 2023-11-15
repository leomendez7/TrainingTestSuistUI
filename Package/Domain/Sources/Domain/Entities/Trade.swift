//
//  Transaction.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import Foundation

public struct Trade: Identifiable, Codable {
    
    public var id = UUID()
    public var email: String = ""
    public var category: String = ""
    public var description: String = ""
    public var value: String = ""
    public var isIncome: Bool = false
    public var payment: String = ""
    public var reminder: Bool = false
    public var date = Date()
    
    public init() { }
    
    enum CodingKeys: String, CodingKey {
        case email
        case category
        case description
        case value
        case isIncome
        case payment
        case reminder
        case date
    }
    
}
