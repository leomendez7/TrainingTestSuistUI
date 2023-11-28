//
//  SelectFrequencyView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI
import Domain

public struct SelectFrequencyView: View {
    
    @State private var selectedTab = 0
    @Binding var selectedFrequency: String
    @EnvironmentObject var viewModel: HomeViewModel
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<viewModel.segments.count, id: \.self) { index in
                Button(action: {
                    selectedTab = index
                    self.selectedFrequency = viewModel.segments[index]
                }) {
                    Text(viewModel.segments[index])
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .frame(width: 90, height: 56)
                        .foregroundColor(selectedTab == index ? Color(.yellow100) : Color(.light20))
                }
                .background(selectedTab == index ? Color(.yellow20) : .white)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(selectedTab == index ? Color(.yellow20) : .white, lineWidth: 1)
                )
            }
        }
        .frame(height: 34)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.light80), lineWidth: 1)
        )
    }
}

#Preview {
    SelectFrequencyView(selectedFrequency: .constant(""))
        .environmentObject(Constants.homeViewModel)
}


