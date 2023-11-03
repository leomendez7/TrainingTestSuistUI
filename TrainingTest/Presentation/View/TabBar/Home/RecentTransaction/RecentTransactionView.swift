//
//  RecentTransactionView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI

struct RecentTransactionView: View {
    
    @ObservedObject var viewModel: TransactionViewModel
    
    var transactions = [Transaction]()
    
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                Text("Spend Frequency")
                    .foregroundColor(.dark)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Spacer()
                CustomButton(action: {
                    
                }, text: "See All",
                             color: .violet20,
                             foregroundColor: .violet100,
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
    RecentTransactionView(viewModel: TransactionViewModel())
}
