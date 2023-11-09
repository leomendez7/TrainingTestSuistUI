//
//  CurrencyView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import SwiftUI

struct CurrencyView: View {
    
    @EnvironmentObject var viewModel: CurrencyViewModel
    @EnvironmentObject var store: Store
    @State var isCurrencySelected = Currency()
    
    var backButton : some View {
        Button(action: {
            store.settings.removeLast()
        }) {
            HStack {
                Image("arrow-left", bundle: .module)
                    .foregroundColor(Color("dark-25", bundle: .module))
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(viewModel.currencies.indices, id: \.self) { index in
                CurrencyOptionsView(optionName: viewModel.currencies[index].name, 
                                    isCurrencySelected: $isCurrencySelected)
                    .onTapGesture {
                        isCurrencySelected = viewModel.currencies[index]
                        Default.save(currency: viewModel.currencies[index].abbreviation)
                    }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .navigationTitle("Currency")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: backButton)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
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
