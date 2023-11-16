//
//  TransactionCellView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI
import Domain

struct TransactionCellView: View {
    
    @State var image: String
    @State var background: Color
    @State var trade: Trade
    @State private var hourText = String()
    
    var body: some View {
        HStack(spacing: 10) {
            Image(image, bundle: .module)
                .padding(15)
                .frame(width: 60, height: 60)
                .background(background)
                .cornerRadius(16)
            VStack(alignment: .leading, spacing: 13) {
                Text(trade.category)
                    .foregroundColor(Color(.dark25))
                    .font(.system(size: 14))
                Text(trade.description)
                    .foregroundColor(Color(.light20))
                    .font(.system(size: 13))
                    .fontWeight(.semibold)
                    .lineLimit(1)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 13) {
                if !trade.isIncome {
                    Text("- $\(trade.value)")
                        .foregroundColor(Color(.red100))
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                } else {
                    Text("+ $\(trade.value)")
                        .foregroundColor(Color(.green100))
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                }
                Text(hourText)
                    .foregroundColor(Color(.light20))
                    .font(.system(size: 13))
                    .fontWeight(.semibold)
            }
        }
        .frame(height: 89)
        .padding(.horizontal, 16)
        .background(Color(.light80))
        .cornerRadius(24)
        .onAppear {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            hourText = formatter.string(from: trade.createDate)
        }
    }
}

#Preview {
    TransactionCellView(image: "shopping-bag",
                        background: Color(.yellow20),
                        trade: Trade())
}
