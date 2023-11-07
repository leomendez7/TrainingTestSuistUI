//
//  CurrencyView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import SwiftUI

struct CurrencyView: View {
    
    @EnvironmentObject var viewModel: CurrencyViewModel
    @State var isSelected = Bool()
    
    var body: some View {
        VStack(spacing: 9) {
            ForEach(viewModel.currencies.indices, id: \.self) { index in
                CurrencyOptionsView(optionName: viewModel.currencies[index], isSelected: isSelected)
                    .onTapGesture {
                        isSelected = true
                    }
            }
            .navigationTitle("Currency")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CurrencyView()
}
