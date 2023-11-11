//
//  File.swift
//  
//
//  Created by Leonardo Mendez on 10/11/23.
//

import Foundation
import Domain

public class BaseViewModel<UseCase> {
    
    public var useCase: UseCase
    
    public init(useCase: UseCase) {
        self.useCase = useCase
    }
    
}

public extension BaseViewModel where UseCase == Array<any UseCaseProtocol> {
    func getUseCase<T: UseCaseProtocol>(typeOfUseCase: T.Type) -> T? {
        return useCase.first(where: { $0 is T }) as? T
    }
}
