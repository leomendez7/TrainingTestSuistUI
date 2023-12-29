//
//  SelectorView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import SwiftUI
import Domain

struct CategorySelectorView: View {
    
    @State private var selectedCategoryIndex = 0
    @Binding var selectedCategory: CategoryName
    let categories = [CategoryName.shopping,
                      CategoryName.subscription,
                      CategoryName.food,
                      CategoryName.salary,
                      CategoryName.transportation]
    
    var body: some View {
        Menu {
            ForEach(0..<categories.count, id: \.self) { index in
                Button(action: {
                    selectedCategoryIndex = index
                }) {
                    Text(categories[index].rawValue)
                }
            }
        } label: {
            HStack {
                HStack {
                    Circle()
                        .fill(Color(.green100))
                        .frame(width: 14, height: 14)
                    Text(selectedCategory.rawValue)
                        .font(.system(size: 18))
                        .foregroundColor(Color(.dark))
                }
                .padding(.horizontal, 8)
                .frame(height: 33)
                .background(Color(.light80))
                .cornerRadius(32)
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color(.light60), lineWidth: 1)
                )
                Spacer()
                Image("arrow-down-2", bundle: .module)
            }
            .padding(.horizontal, 16)
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
    CategorySelectorView(selectedCategory: .constant(CategoryName.shopping))
}
