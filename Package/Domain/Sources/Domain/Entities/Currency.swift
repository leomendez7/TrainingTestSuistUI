//
//  Currency.swift
//
//
//  Created by Leonardo Mendez on 9/11/23.
//

import Foundation

public struct Currency: Identifiable, Codable {
    
    public var id = UUID()
    public var name: String = ""
    public var abbreviation: AbbreviationCurrency = .usd
    
    public init() { }
    
    enum CodingKeys: String, CodingKey {
        case name
        case abbreviation = "abbreviation"
    }
    
}

public enum AbbreviationCurrency: String, Codable {
    case usd = "USD"
    case jpy = "JPY"
    case eur = "EUR"
    case cop = "COP"
    case pre = "Preference"

}
