//
//  RecentTransactionView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI
import Domain

struct RecentTransactionView: View {
    
    @Binding var seeAll: Bool
    @Binding var selectedTrade: Trade
    @State var image = ""
    @EnvironmentObject var viewModel: HomeViewModel
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                Text("Spend Frequency")
                    .foregroundColor(Color(.dark))
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Spacer()
                CustomButton(action: {
                    seeAll.toggle()
                }, text: "See All",
                             color: Color(.violet20),
                             foregroundColor: Color(.violet100),
                             height: 32,
                             width: 78,
                             cornerRadius: 40,
                             fontSize: 14)
            }
            .padding(.top, 31)
            VStack(spacing: 8) {
                ForEach(viewModel.transactions.indices, id: \.self) { index in
                    TransactionCellView(trade: $viewModel.transactions[index])
                        .onTapGesture {
                            selectedTrade = viewModel.transactions[index]
                            store.transactions.append("TransactionDetails")
                        }
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
}

#Preview {
    RecentTransactionView(seeAll: .constant(Bool()), selectedTrade: .constant(Trade()))
        .environmentObject(Store())
        .environmentObject(Constants.homeViewModel)
}
