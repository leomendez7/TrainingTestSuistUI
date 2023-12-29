//
//  TransactionDetailsHeaderView.swift
//
//
//  Created by Leonardo Mendez on 20/11/23.
//

import SwiftUI
import Domain

struct TransactionDetailsHeaderView: View {
    
    @Binding var transaction: Trade
    @State var date: String = ""
    @State private var backgroundColor: Color = Color(.green100)
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 16) {
                Spacer()
                Text("$\(transaction.value)")
                    .foregroundColor(Color(.light80))
                    .font(.system(size: 48))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                Text(date)
                    .foregroundColor(Color(.light80))
                    .font(.system(size: 16))
                    .padding(.bottom, 56)
            }
        }
        .frame(maxWidth: .infinity)
        .bottomRoundedCorners(cornerRadius: 20, backgroundColor: backgroundColor)
        .onAppear {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE d MMMM yyyy h:mm a"
            date = dateFormatter.string(from: transaction.createDate)
            backgroundColor = transaction.isIncome ? Color(.green100) : Color(.red100)
        }
    }
    
}

#Preview {
    TransactionDetailsHeaderView(transaction: .constant(Trade()))
}
