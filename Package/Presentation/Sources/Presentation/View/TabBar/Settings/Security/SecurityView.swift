//
//  SecurityView.swift
//
//
//  Created by Leonardo Mendez on 9/11/23.
//

import SwiftUI
import Domain

struct SecurityView: View {
    
    @EnvironmentObject var viewModel: SecurityViewModel
    @EnvironmentObject var store: Store
    @State var isSecuritySelected = Security()
    
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
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .navigationBarItems(leading: BackNavigationButton(action: {
            store.settings.removeLast()
        }, image: "arrow-left", color: Color(.dark25)))
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
