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
    @State var isSelected = Bool()
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
        VStack(spacing: 9) {
            ForEach(viewModel.currencies.indices, id: \.self) { index in
                CurrencyOptionsView(optionName: viewModel.currencies[index], isSelected: isSelected)
                    .onTapGesture {
                        isSelected = true
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
    }
}

#Preview {
    NavigationStack {
        CurrencyView()
            .environmentObject(CurrencyViewModel())
            .environmentObject(Store())
    }
}
