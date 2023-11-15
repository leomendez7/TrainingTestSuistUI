//
//  SelectorView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import SwiftUI

struct CategorySelectorView: View {
    
    @State private var selectedCategoryIndex = 0
    @Binding var selectedCategory: String
    let categories = ["Shopping", "Subscription", "Food", "Salary", "Transportation"]
    
    var body: some View {
        Menu {
            ForEach(0..<categories.count, id: \.self) { index in
                Button(action: {
                    selectedCategoryIndex = index
                }) {
                    Text(categories[index])
                }
            }
        } label: {
            HStack {
                Text(selectedCategory)
                    .font(.system(size: 18))
                    .foregroundColor(Color(.light20))
                    .padding(.horizontal, 16)
                Spacer()
                Image("arrow-down-2", bundle: .module)
                    .padding(.horizontal, 16)
            }
            .frame(height: 56)
            .background(.white)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.light60), lineWidth: 1)
            )
            .onChange(of: selectedCategoryIndex) { _ in
                selectedCategory = categories[selectedCategoryIndex]
            }
        }
    }
}

#Preview {
    CategorySelectorView(selectedCategory: .constant("Shopping"))
}
