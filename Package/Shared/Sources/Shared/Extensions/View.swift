//
//  SwiftUIView.swift
//  
//
//  Created by Leonardo Mendez on 18/11/23.
//

import SwiftUI

public extension View {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil,
                                        from: nil,
                                        for: nil)
    }
    
}
