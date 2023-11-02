//
//  RecentTransactionView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI

struct RecentTransactionView: View {
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
                TransactionCellView(name: "Shopping",
                                    description: "Buy some grocery",
                                    value: "120",
                                    hour: "10:00 AM",
                                    image: "shopping-bag",
                                    background: .yellow20)
                TransactionCellView(name: "Subscription",
                                    description: "Disney+ Annual",
                                    value: "80",
                                    hour: "03:30 PM",
                                    image: "recurring-bill",
                                    background: .violet20)
                TransactionCellView(name: "food",
                                    description: "Buy a ramen",
                                    value: "32",
                                    hour: "07:00 PM",
                                    image: "restaurant",
                                    background: .red20)
            }
            
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    RecentTransactionView()
}
