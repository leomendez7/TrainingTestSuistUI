//
//  TransactionsView.swift.swift
//
//
//  Created by Leonardo Mendez on 10/11/23.
//

import SwiftUI

struct TransactionsView: View {
    
    @EnvironmentObject var viewModel: TransactionViewModel
    @State private var isSheetPresented = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack(spacing: 8) {
                        Text("Today")
                            .foregroundColor(Color(.dark))
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                        Spacer()
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
                    HStack(spacing: 8) {
                        Text("Yesterday")
                            .foregroundColor(Color(.dark))
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                        Spacer()
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
            }
            .transactionToolbar(isSheetPresented: $isSheetPresented)
        }
        .padding(.horizontal, 16)
        .task {
            viewModel.fetchTransactions()
        }
    }
    
}

#Preview {
    VStack {
        TransactionsView()
            .environmentObject(TransactionViewModel())
    }
}
