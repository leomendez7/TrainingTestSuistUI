//
//  CodableJSON.swift
//
//
//  Created by Leonardo Mendez on 14/11/23.
//

import Foundation

public extension Encodable {
    
    func convertToJSON() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]) ?? [:]
    }
    
    func convertToJSONString() -> String {
        guard let data = try? JSONEncoder().encode(self) else { return "" }
        return String(data: data, encoding: .utf8) ?? ""
    }
}
