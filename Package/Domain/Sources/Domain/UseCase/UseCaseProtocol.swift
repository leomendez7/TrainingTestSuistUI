//
//  UseCaseProtocol.swift
//
//
//  Created by Leonardo Mendez on 10/11/23.
//

import Foundation

public protocol UseCaseProtocol {
    associatedtype RequestValue
    associatedtype ResponseValue
    func execute(requestValue: RequestValue) async throws -> ResponseValue
}
