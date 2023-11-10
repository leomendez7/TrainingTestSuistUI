//
//  SecurityViewModel.swift
//
//
//  Created by Leonardo Mendez on 9/11/23.
//

import Foundation
import Combine
import SwiftUI

public class SecurityViewModel: ObservableObject {
    
    @Published var securities = [Security]()
    
    func generateSecurities() {
        let securityNames: [String] = ["PIN",
                                       "Biometric Authentication"]
        securities.removeAll()
        for index in 0...securityNames.count - 1 {
            var security = Security()
            security.name = securityNames[index]
            self.securities.append(security)
        }
    }
    
}
