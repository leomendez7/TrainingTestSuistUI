//
//  CategoryByView.swift
//
//
//  Created by Leonardo Mendez on 29/11/23.
//

import SwiftUI

struct CategoryByView: View {
   
    @State var categoriesSelected: Int = 0
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
                    Text("\(categoriesSelected) Selected")
                        .textModifierStyle(size: 14, color: Color(.light20), weight: .regular)
                    Image("arrow-right", bundle: .module)
                }
            }
            .onTapGesture {
                store.category.append("SelectCategory")
            }
        }
    }
    
}

#Preview {
    CategoryByView()
        .environmentObject(Store())
}
