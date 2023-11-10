//
//  CurrencyViewModel.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import Foundation
import Combine
import SwiftUI
import Domain

public class CurrencyViewModel: ObservableObject {
    
    @Published var currencies = [Currency]()
    
    func generateCurrencies() {
        let currenciesNames: [String] = ["United States (USD)",
                                         "Japan (JPY)",
                                         "Euro (EUR)",
                                         "Colombia (COP)",
                                         "Use system preference"]
        let abbreviations: [String] = ["USD",
                                       "JPY",
                                       "EUR",
                                       "COP",
                                       "Preference"]
        currencies.removeAll()
        for index in 0...currenciesNames.count - 1 {
            var currency = Currency()
            currency.name = currenciesNames[index]
            currency.abbreviation = abbreviations[index]
            self.currencies.append(currency)
        }
    }
    
}
