//
//  MonthSwitcherView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

struct MonthSwitcherView: View {
    
    @State private var selectedMonthIndex = 0
    @State private var isSheetPresented = false
    @EnvironmentObject var viewModel: TransactionViewModel
    
    var body: some View {
        HStack() {
            Spacer()
            Menu {
                ForEach(0..<viewModel.months.count, id: \.self) { index in
                    Button(action: {
                        selectedMonthIndex = index
                    }) {
                        Text(viewModel.months[index])
                    }
                }
            } label: {
                HStack {
                    Image("arrow-down", bundle: .module)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 12)
                    if !viewModel.months.isEmpty {
                        Text(viewModel.months[selectedMonthIndex])
                            .font(.system(size: 18))
                            .padding(.trailing, 16)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                            .foregroundColor(Color(.dark50))
                    }
                }
                .frame(height: 35)
                .background(.clear)
                .cornerRadius(40)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color(.light60), lineWidth: 1)
                )
            }
            Spacer()
        }
        .onChange(of: selectedMonthIndex) { _ in
            viewModel.selectedMont = viewModel.months[selectedMonthIndex]
            viewModel.fetchTransactions()
        }
        .onAppear {
            viewModel.generateMonths()
            selectedMonthIndex = viewModel.currentMonth
        }
    }
}

#Preview {
    MonthSwitcherView()
        .environmentObject(TransactionViewModel())
}
