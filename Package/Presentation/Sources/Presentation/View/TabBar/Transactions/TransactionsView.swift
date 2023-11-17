//
//  TransactionsView.swift.swift
//
//
//  Created by Leonardo Mendez on 10/11/23.
//

import SwiftUI

struct TransactionsView: View {
    
    @StateObject var viewModel: HomeViewModel
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
                            TransactionCellView(image: viewModel.images[index],
                                                background: viewModel.colors[index],
                                                trade: viewModel.transactions[index])
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
                            TransactionCellView(image: viewModel.images[index],
                                                background: viewModel.colors[index],
                                                trade: viewModel.transactions[index])
                        }
                    }
                }
            }
            .transactionToolbar(isSheetPresented: $isSheetPresented)
            .environmentObject(viewModel)
        }
        .padding(.horizontal, 16)
        .onAppear {
            Task {
                await viewModel.fetchTransactions()
            }
        }
    }
    
}

#Preview {
    VStack {
        TransactionsView(viewModel: Constants.transactionViewModel)
    }
}
