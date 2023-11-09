//
//  SelectFrequencyView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI

public struct SelectFrequencyView: View {
    
    @State private var selectedTab = 0
    private let segments = ["Today", "Week", "Month", "Year"]
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<segments.count, id: \.self) { index in
                Button(action: {
                    selectedTab = index
                }) {
                    Text(segments[index])
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .frame(width: 90, height: 56)
                        .foregroundColor(selectedTab == index ? Color("yellow-100", bundle: .module) : Color("light-20", bundle: .module))
                }
                .background(selectedTab == index ? Color("yellow-20", bundle: .module) : .white)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(selectedTab == index ? Color("yellow-20", bundle: .module) : .white, lineWidth: 1)
                )
            }
        }
        .frame(height: 34)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("light-80", bundle: .module), lineWidth: 1)
        )
    }
}

#Preview {
    SelectFrequencyView()
}


