//
//  FrequencyView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI

struct FrequencyView: View {
    
    @State var index = 0
    @State var selectedFrequency: String = ""
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Spend Frequency")
                    .textModifierStyle(size: 18, color: Color(.dark), weight: .bold)
                    .padding(.horizontal, 16)
                Spacer()
            }
            ChartTransactionsView()
            SelectFrequencyView(selectedFrequency: $selectedFrequency)
                .padding(.horizontal, 16)
        }
        .onAppear {
            selectedFrequency = viewModel.selectedFrequency
        }
        .onChange(of: selectedFrequency) { _ in                   
            viewModel.selectedFrequency = selectedFrequency
            viewModel.spendFrequency()
        }
        .onChange(of: viewModel.selectedMont) { _ in
            viewModel.spendFrequency()
            selectedFrequency = viewModel.selectedFrequency
        }
        .padding(.top, 31)
    }
}

#Preview {
    FrequencyView()
        .environmentObject(Constants.homeViewModel)
}


