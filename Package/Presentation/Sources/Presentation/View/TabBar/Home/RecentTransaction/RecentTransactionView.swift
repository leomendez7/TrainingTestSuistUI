//
//  RecentTransactionView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI

struct RecentTransactionView: View {
    
    @EnvironmentObject var viewModel: TransactionViewModel
    
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                Text("Spend Frequency")
                    .foregroundColor(Color(.dark))
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Spacer()
                CustomButton(action: {
                    
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
                    TransactionCellView(name: viewModel.transactions[index].name,
                                        description: viewModel.transactions[index].description,
                                        value: viewModel.transactions[index].value,
                                        hour: viewModel.transactions[index].hour,
                                        image: viewModel.images[index],
                                        background: viewModel.colors[index])
                }
            }
        }
        .padding(.horizontal, 16)
        .task {
            viewModel.fetchTransactions()
        }
    }
    
}

#Preview {
    RecentTransactionView()
        .environmentObject(TransactionViewModel())
}
