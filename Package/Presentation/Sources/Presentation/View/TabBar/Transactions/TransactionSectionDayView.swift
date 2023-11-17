//
//  SwiftUIView.swift
//  
//
//  Created by Leonardo Mendez on 17/11/23.
//

import SwiftUI
import Domain

struct TransactionSectionDayView: View {
    
    var date: Date
    var transactions: [Trade]
    @StateObject var viewModel: TransactionsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(sectionTitle(for: date))
                .foregroundColor(Color(.dark))
                .font(.system(size: 18))
                .fontWeight(.bold)
                .padding(.top, 31)
            ForEach(transactions) { transaction in
                TransactionCellView(trade: transaction)
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
    TransactionSectionDayView(date: Date(), transactions: [Trade](), viewModel: Constants.transactionViewModel)
}
