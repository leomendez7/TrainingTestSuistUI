//
//  CurrencyViewModel.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import Foundation
import Combine
import SwiftUI

public class CurrencyViewModel: ObservableObject {
    
    @Published var currencies = [Currency]()
    
    func generateCurrencies() {
        let currencies: [String] = ["United States (USD)",
                                    "Japan (JPY)",
                                    "Euro (EUR)",
                                    "Colombia (COP)",
                                    "Use system preference"]
        let abbreviations: [String] = ["USD",
                                       "JPY",
                                       "EUR",
                                       "COP",
                                       "preference"]
        for index in 0...currencies.count - 1 {
            var currency = Currency(id: UUID(), name: currencies[index], abbreviation:  abbreviations[index])
            self.currencies.append(currency)
        }
    }
    
}
