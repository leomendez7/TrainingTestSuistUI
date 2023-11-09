//
//  CurrencyOptionsView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import SwiftUI

struct CurrencyOptionsView: View {
    
    @State var optionName: String
    @Binding var isSelected: Bool
    @EnvironmentObject var setDefault: Default
    
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
    CurrencyOptionsView(optionName: "United States (USD)", isSelected: .constant(true))
}
