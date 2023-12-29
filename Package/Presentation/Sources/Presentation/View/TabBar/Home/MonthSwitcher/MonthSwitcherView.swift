//
//  MonthSwitcherView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

struct MonthSwitcherView: View {
    
    @State private var selectedMonthIndex = 0
    @State var changeMonth: Bool = false
    @State private var isSheetPresented = false
    @Binding var currentMonth: Int
    @Binding var months: [String]
    @Binding var selectedMont: String
    @Binding var isChangeMonth: Bool
    
    var body: some View {
        HStack() {
            Spacer()
            Menu {
                ForEach(0..<months.count, id: \.self) { index in
                    Button(action: {
                        selectedMonthIndex = index
                        changeMonth.toggle()
                    }) {
                        Text(months[index])
                    }
                }
            } label: {
                HStack {
                    Image("arrow-down", bundle: .module)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 12)
                    if !months.isEmpty {
                        Text(months[selectedMonthIndex])
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
        .onChange(of: changeMonth) { _ in
            selectedMont = months[selectedMonthIndex]
            isChangeMonth.toggle()
        }
        .onAppear {
            selectedMonthIndex = currentMonth
        }
    }
}

#Preview {
    MonthSwitcherView(currentMonth: .constant(0), 
                      months: .constant([String]()),
                      selectedMont: .constant(String()),
                      isChangeMonth: .constant(Bool()))
}
