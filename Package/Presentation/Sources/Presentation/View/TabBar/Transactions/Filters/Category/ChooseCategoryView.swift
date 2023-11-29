//
//  SwiftUIView.swift
//  
//
//  Created by Leonardo Mendez on 29/11/23.
//

import SwiftUI

struct ChooseCategoryView: View {
    
    var name: String
    @Binding var selected: Bool
    @State private var image: String = "shopping-bag"
    @State private var background: Color = Color(.yellow20)
    
    var body: some View {
        HStack {
            Image(image, bundle: .module)
                .padding(15)
                .frame(width: 60, height: 60)
                .background(background)
                .cornerRadius(16)
            Text(name)
            Spacer()
            if selected {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 21,height: 21)
                    .foregroundColor(Color(.violet100))
            }
        }
        .onAppear {
            configureImage()
        }
    }
    
    private func configureImage() {
        switch name {
        case "Shopping":
            image = "shopping-bag"
            background = Color(.yellow20)
        case "Subscription":
            image = "recurring-bill"
            background = Color(.violet20)
        case "Food":
            image = "restaurant"
            background = Color(.red20)
        case "Salary":
            image = "salary"
            background = Color(.green20)
        default:
            image = "transportation"
            background = Color(.blue20)
        }
    }
    
}

#Preview {
    ChooseCategoryView(name: "Shopping", selected: .constant(true))
}
