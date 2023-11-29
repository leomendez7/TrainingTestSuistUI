//
//  SwiftUIView.swift
//  
//
//  Created by Leonardo Mendez on 29/11/23.
//

import SwiftUI

struct SelectCategoryView: View {
    
    @StateObject var viewModel: TransactionsViewModel
    @State var selectedShopping = false
    @State var selectedSubscription = false
    @State var selectedFood = false
    @State var selectedSalary = false
    @State var selectedTransportation = false
    
    var body: some View {
        VStack {
            ChooseCategoryView(name: "Shopping", selected: $selectedShopping)
            .onTapGesture {
                selectedShopping.toggle()
                saveSelectedCategory(name: "Shopping")
            }
            ChooseCategoryView(name: "Subscription", selected: $selectedSubscription)
                .onTapGesture {
                    selectedSubscription.toggle()
                    saveSelectedCategory(name: "Subscription")
                }
            ChooseCategoryView(name: "Food", selected: $selectedFood)
                .onTapGesture {
                    selectedFood.toggle()
                    saveSelectedCategory(name: "Food")
                }
            ChooseCategoryView(name: "Salary", selected: $selectedSalary)
                .onTapGesture {
                    selectedSalary.toggle()
                    saveSelectedCategory(name: "Salary")
                }
            ChooseCategoryView(name: "Transportation", selected: $selectedTransportation)
                .onTapGesture {
                    selectedTransportation.toggle()
                    saveSelectedCategory(name: "Transportation")
                }
            Spacer()
        }
        .padding( 16)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackNavigationButton(action: {
            viewModel.store.category.removeLast()
        }, image: "arrow-left", color: Color(.dark25)))
    }
    
    func saveSelectedCategory(name: String) {
        if viewModel.selectedCategories.contains(name) {
            viewModel.selectedCategories.removeAll { $0 == name }
        } else {
            viewModel.selectedCategories.append(name)
        }
        print(viewModel.selectedCategories)
    }
    
}

#Preview {
    SelectCategoryView(viewModel: Constants.transactionViewModel)
}
