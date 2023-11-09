//
//  CurrencyOptionsView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import SwiftUI

struct CurrencyOptionsView: View {
    
    @State var optionName: String
    @Binding var isCurrencySelected: Currency
    
    var body: some View {
        HStack {
            Text(optionName)
            Spacer()
            if isCurrencySelected.name == optionName {
                Image("success", bundle: .module)
                    .frame(width: 24,height: 24)
            }
        }
    }
    
}

#Preview {
    CurrencyOptionsView(optionName: "United States (USD)",
                        isCurrencySelected: .constant(Currency()))
}
