//
//  ChartTransactionsView.swift
//  
//
//  Created by Leonardo Mendez on 27/11/23.
//

import SwiftUI
import Charts

struct ChartTransactionsView: View {
    
    @State var index = 0
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        Chart {
            ForEach(viewModel.frequencyTrades.indices, id: \.self) { index in
                LineMark(
                    x: .value("trades", index),
                    y: .value("balance", Double(viewModel.frequencyTrades[index].balanceLast))
                )
                .interpolationMethod(.catmullRom)
                .lineStyle(StrokeStyle(lineWidth: 6))
                .foregroundStyle(Color(.violet100))
                AreaMark(
                    x: .value("trades", index),
                    y: .value("balance", Double(viewModel.frequencyTrades[index].balanceLast))
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient (
                            colors: [
                                Color(.violet80).opacity(0.24),
                                Color(.violet80).opacity(0.0),
                            ]
                        ),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .frame(maxHeight: 380)
    }
}

#Preview {
    ChartTransactionsView()
        .environmentObject(Constants.homeViewModel)
}
