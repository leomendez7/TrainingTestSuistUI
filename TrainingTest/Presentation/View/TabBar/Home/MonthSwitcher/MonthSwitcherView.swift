//
//  MonthSwitcherView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

struct MonthSwitcherView: View {
    @State private var selectedMonthIndex = 0
    let months = ["January",
                  "February",
                  "March",
                  "April",
                  "May",
                  "June",
                  "July",
                  "August",
                  "September",
                  "October",
                  "November",
                  "December"]
    var body: some View {
        HStack() {
            Circle()
                .frame(width: 35, height: 35)
                .foregroundColor(.white)
                .overlay(
                    Image("avatar")
                        .resizable()
                        .frame(width: 40, height: 40)
                )
            Spacer()
            HStack(spacing: 9) {
                Image("arrow-down")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 12)
                Text(months[selectedMonthIndex])
                    .font(.system(size: 18))
                    .padding(.trailing, 16)
                    .padding(.top, 11)
                    .padding(.bottom, 11)
                
            }
            .frame(height: 56)
            .background(.white)
            .cornerRadius(40)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(.light60, lineWidth: 1)
            )
            .onTapGesture {
                selectedMonthIndex = (selectedMonthIndex + 1) % months.count
            }
            Spacer()
            Button(action: {
                
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.violet100)
            }
        }
        .padding(.top, 12)
        .padding(.leading, 16)
        .padding(.trailing, 16)
    }
}

#Preview {
    MonthSwitcherView()
}
