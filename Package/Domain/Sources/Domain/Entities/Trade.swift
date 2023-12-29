//
//  Transaction.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import Foundation
import UIKit

public struct Trade: Identifiable, Codable, Equatable {
    
    public var id = UUID().uuidString
    public var email: String = ""
    public var category: CategoryName = .shopping
    public var description: String = ""
    public var value: String = ""
    public var isIncome: Bool = false
    public var payment: String = ""
    public var reminder: Bool = false
    public var createDate = Date()
    public var image: String = ""
    public var balanceLast: Double = 0.0
    
    public init() { }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case category
        case description
        case value
        case isIncome
        case payment
        case reminder
        case createDate
        case image
        case balanceLast
    }
    
    
}

public enum CategoryName: String, Codable {
    case shopping = "Shopping"
    case subscription = "Subscription"
    case food = "Food"
    case salary = "Salary"
    case transportation = "Transportation"
}
