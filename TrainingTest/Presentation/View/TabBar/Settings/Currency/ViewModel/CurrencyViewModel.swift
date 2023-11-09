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
    
    @Published var currencies: [String] = ["United States (USD)",
                                                  "Japan (JPY)",
                                                  "Euro (EUR)",
                                                  "Colombia (COP)",
                                                  "Use system preference"]
    
    
}
