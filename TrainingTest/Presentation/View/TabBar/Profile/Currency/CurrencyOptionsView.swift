//
//  CurrencyOptionsView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import SwiftUI

struct CurrencyOptionsView: View {
    
    
    @State var optionName: String
    @State var isSelected = Bool()
    
    var body: some View {
        HStack {
            Text(optionName)
            Spacer()
            if isSelected {
                Image("success")
            }
        }
    }
    
}

#Preview {
    CurrencyOptionsView(optionName: "United States (USD)")
}
