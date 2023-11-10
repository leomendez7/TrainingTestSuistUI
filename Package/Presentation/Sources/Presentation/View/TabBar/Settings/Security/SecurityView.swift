//
//  SecurityView.swift
//
//
//  Created by Leonardo Mendez on 9/11/23.
//

import SwiftUI

struct SecurityView: View {
    
    @EnvironmentObject var viewModel: SecurityViewModel
    @EnvironmentObject var store: Store
    @State var isSecuritySelected = Security()
    
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
        VStack(spacing: 24) {
            ForEach(viewModel.securities.indices, id: \.self) { index in
                SecurityOptionsView(optionName: viewModel.securities[index].name,
                                    isSecuritySelected: $isSecuritySelected)
                    .onTapGesture {
                        isSecuritySelected = viewModel.securities[index]
                        Default.save(security: viewModel.securities[index])
                    }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .navigationTitle("Security")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: backButton)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .task {
            viewModel.generateSecurities()
        }
    }
    
}

#Preview {
    SecurityView()
        .environmentObject(Store())
        .environmentObject(SecurityViewModel())
}
