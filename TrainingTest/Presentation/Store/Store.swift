//
//  Store.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 3/11/23.
//

import SwiftUI

public class Store: ObservableObject {
    
    @Published var onboarding = NavigationPath()
    @Published var transactions = NavigationPath()
    
}
