//
//  FrequencyView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI

struct FrequencyView: View {
    
    @State var index = 0
    @State var selectedFrequency: String = "Today"
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Spend Frequency")
                    .textModifierStyle(size: 18, color: Color(.dark), weight: .bold)
                    .padding(.horizontal, 16)
                Spacer()
            }
            ChartDayView()
            SelectFrequencyView(selectedFrequency: $selectedFrequency)
                .padding(.horizontal, 16)
        }
        .onChange(of: selectedFrequency) { _ in
            viewModel.selectedFrequency = selectedFrequency
            viewModel.spendFrequency()
        }
        .padding(.top, 31)
    }
}

#Preview {
    FrequencyView()
}


