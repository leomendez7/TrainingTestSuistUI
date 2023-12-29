//
//  CurrencyOptionsView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import SwiftUI
import Domain

struct CurrencyOptionsView: View {
    
    @State var optionName: String
    @Binding var isCurrencySelected: Currency
    
    var body: some View {
        HStack {
            Text(optionName)
            Spacer()
            if isCurrencySelected.name == optionName {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 21,height: 21)
                    .foregroundColor(Color(.violet100))
            }
        }
        .onAppear {
            if Default.currency().name.isEmpty {
                var currency = Currency()
                currency.name = "United States (USD)"
                currency.abbreviation = .usd
                isCurrencySelected = currency
            } else {
                isCurrencySelected = Default.currency()
            }
        }
    }
    
}

#Preview {
    CurrencyOptionsView(optionName: "United States (USD)",
                        isCurrencySelected: .constant(Currency()))
}
