//
//  SortByView.swift
//  
//
//  Created by Leonardo Mendez on 28/11/23.
//

import SwiftUI

struct SortByView: View {
    
    @Binding var filterCount: Int
    @Binding var reset: Bool
    @State var colorHighest: Color = .white
    @State var foregroundColorHighest: Color = Color(.dark)
    @State var colorLowest: Color = .white
    @State var foregroundColorLowest: Color = Color(.dark)
    @State var colorNewest: Color = .white
    @State var foregroundColorNewest: Color = Color(.dark)
    @State var colorOldest: Color = .white
    @State var foregroundColorOldest: Color = Color(.dark)
    @State var isSelected: Bool = false
    @State var isHighest: Bool = false
    @State var isLowest: Bool = false
    @State var isNewest: Bool = false
    @State var isOldest: Bool = false
    @EnvironmentObject var viewModel: TransactionsViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Sort By")
                    .textModifierStyle(size: 16, color: Color(.dark), weight: .semibold)
                Spacer()
            }
            VStack {
                HStack(spacing: 8) {
                    SelectedButtonView(action: {
                        if !isSelected {  filterCount += 1 }
                        isSelected.toggle()
                        isHighest = true
                        isLowest = false
                        isNewest = false
                        isOldest = false
                    }, text: "Highest", foregroundColor: foregroundColorHighest, backgroundColor: colorHighest)
                    SelectedButtonView(action: {
                        if !isSelected {  filterCount += 1 }
                        isSelected.toggle()
                        isHighest = false
                        isLowest = true
                        isNewest = false
                        isOldest = false
                    }, text: "Lowest", foregroundColor: foregroundColorLowest, backgroundColor: colorLowest)
                    SelectedButtonView(action: {
                        if !isSelected {  filterCount += 1 }
                        isSelected.toggle()
                        isHighest = false
                        isLowest = false
                        isNewest = true
                        isOldest = false
                    }, text: "Newest", foregroundColor: foregroundColorNewest, backgroundColor: colorNewest)
                    Spacer()
                }
                HStack {
                    SelectedButtonView(action: {
                        if !isSelected {  filterCount += 1 }
                        isSelected.toggle()
                        isHighest = false
                        isLowest = false
                        isNewest = false
                        isOldest = true
                    }, text: "Oldest", foregroundColor: foregroundColorOldest, backgroundColor: colorOldest)
                    Spacer()
                }
            }
        }
        .onAppear {
            isHighest = viewModel.isHighest
            isLowest = viewModel.isLowest
            isNewest = viewModel.isNewest
            isOldest = viewModel.isOldest
            colorHighest = isHighest ? Color(.violet20) : .white
            foregroundColorHighest = isHighest ? Color(.violet100) : Color(.dark)
            colorLowest = isLowest ? Color(.violet20) : .white
            foregroundColorLowest = isLowest ? Color(.violet100) : Color(.dark)
            colorNewest = isNewest ? Color(.violet20) : .white
            foregroundColorNewest = isNewest ? Color(.violet100) : Color(.dark)
            colorOldest = isOldest ? Color(.violet20) : .white
            foregroundColorOldest = isOldest ? Color(.violet100) : Color(.dark)
        }
        .onChange(of: isSelected) { _ in
            viewModel.activeSort = true
            viewModel.isHighest = isHighest
            viewModel.isLowest = isLowest
            viewModel.isNewest = isNewest
            viewModel.isOldest = isOldest
            colorHighest = isHighest ? Color(.violet20) : .white
            foregroundColorHighest = isHighest ? Color(.violet100) : Color(.dark)
            colorLowest = isLowest ? Color(.violet20) : .white
            foregroundColorLowest = isLowest ? Color(.violet100) : Color(.dark)
            colorNewest = isNewest ? Color(.violet20) : .white
            foregroundColorNewest = isNewest ? Color(.violet100) : Color(.dark)
            colorOldest = isOldest ? Color(.violet20) : .white
            foregroundColorOldest = isOldest ? Color(.violet100) : Color(.dark)
            if filterCount == 0 { filterCount += 1 }
        }
        .onChange(of: reset) { _ in
            colorHighest = .white
            foregroundColorHighest = Color(.dark)
            colorLowest = .white
            foregroundColorLowest = Color(.dark)
            colorNewest = .white
            foregroundColorNewest = Color(.dark)
            colorOldest = .white
            foregroundColorOldest = Color(.dark)
        }
    }
    
}

#Preview {
    SortByView(filterCount: .constant(0), reset: .constant(false))
        .environmentObject(Constants.transactionViewModel)
}
