//
//  TransactionCellView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI
import Domain

struct TransactionCellView: View {
    
    @State private var hourText = String()
    var trade: Trade
    var tradeImage: String {
        switch trade.category {
        case .shopping:
           return "shopping-bag"
        case .subscription:
            return "recurring-bill"
        case .food:
            return "restaurant"
        case .salary:
            return "salary"
        case .transportation:
            return "transportation"
        }
    }
    var background: Color {
        switch trade.category {
        case .shopping:
           return Color(.yellow20)
        case .subscription:
            return Color(.violet20)
        case .food:
            return Color(.red20)
        case .salary:
            return Color(.green20)
        case .transportation:
            return Color(.blue20)
        }
    }
    
    var body: some View {
        HStack(spacing: 10) {
            Image(tradeImage, bundle: .module)
                .padding(15)
                .frame(width: 60, height: 60)
                .background(background)
                .cornerRadius(16)
                VStack(alignment: .leading, spacing: 13) {
                    Text(trade.category.rawValue)
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
        .onChange(of: trade) { _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yy h:mm a"
            hourText = formatter.string(from: trade.createDate)
        }
    }
    
}

#Preview {
    TransactionCellView(trade: Trade())
}
