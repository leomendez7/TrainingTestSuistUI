//
//  CurrencyView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import SwiftUI
import Domain

struct CurrencyView: View {
    
    @EnvironmentObject var viewModel: CurrencyViewModel
    @EnvironmentObject var store: Store
    @State var isCurrencySelected = Currency()
    
    var body: some View {
        VStack(spacing: 24) {
            ForEach(viewModel.currencies.indices, id: \.self) { index in
                CurrencyOptionsView(optionName: viewModel.currencies[index].name, 
                                    isCurrencySelected: $isCurrencySelected)
                    .onTapGesture {
                        isCurrencySelected = viewModel.currencies[index]
                        Default.save(currency: viewModel.currencies[index])
                    }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .navigationTitle("Currency")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .navigationBarItems(leading: BackNavigationButton(action: {
            store.settings.removeLast()
        }, image: "arrow-left", color: Color(.dark25)))
        .task {
            viewModel.generateCurrencies()
        }
    }
    
}

#Preview {
    NavigationStack {
        CurrencyView()
            .environmentObject(CurrencyViewModel())
            .environmentObject(Store())
    }
}
