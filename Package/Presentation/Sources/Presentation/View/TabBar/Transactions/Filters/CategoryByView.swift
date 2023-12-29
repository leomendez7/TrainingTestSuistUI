//
//  CategoryByView.swift
//
//
//  Created by Leonardo Mendez on 29/11/23.
//

import SwiftUI

struct CategoryByView: View {
   
    @Binding var reset: Bool
    @StateObject var viewModel: TransactionsViewModel
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack(spacing: 32) {
            HStack() {
                Text("Category")
                    .textModifierStyle(size: 16, color: Color(.dark), weight: .semibold)
                Spacer()
            }
            HStack {
                Text("Choose Category")
                    .textModifierStyle(size: 16, color: Color(.dark), weight: .regular)
                Spacer()
                HStack {
                    Text("\(viewModel.selectedCategories.count) Selected")
                        .textModifierStyle(size: 14, color: Color(.light20), weight: .regular)
                    Image("arrow-right", bundle: .module)
                }
            }
            .onTapGesture {
                store.category.append("SelectCategory")
            }
            .onChange(of: reset) { _ in
                viewModel.selectedCategories.removeAll()
            }
        }
    }
    
}

#Preview {
    CategoryByView(reset: .constant(false), viewModel: Constants.transactionViewModel)
        .environmentObject(Store())
}
