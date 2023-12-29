//
//  TransactionSectionDayView.swift
//  
//
//  Created by Leonardo Mendez on 17/11/23.
//

import SwiftUI
import Domain

struct TransactionSectionDayView: View {
    
    var date: Date
    @Binding var transactions: [Trade]
    @Binding var selectedTrade: Trade
    @EnvironmentObject var store: Store
    @StateObject var viewModel: TransactionsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(sectionTitle(for: date))
                .foregroundColor(Color(.dark))
                .font(.system(size: 18))
                .fontWeight(.bold)
                .padding(.top, 31)
                .padding(.horizontal, 8)
            ForEach(transactions.indices, id: \.self) { index in
                TransactionCellView(trade: transactions[index])
                    .onTapGesture {
                        selectedTrade = transactions[index]
                        store.transactions.append("TransactionDetails")
                    }
            }
        }
        
    }
    
    private func sectionTitle(for date: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy"
            return dateFormatter.string(from: date)
        }
    }
    
}

#Preview {
    TransactionSectionDayView(date: Date(), 
                              transactions:.constant( [Trade]()),
                              selectedTrade: .constant(Trade()),
                              viewModel: Constants.transactionViewModel)
}
