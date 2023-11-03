//
//  TransactionCellView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI

struct TransactionCellView: View {
    
    @State var name: String
    @State var description: String
    @State var value: String
    @State var hour: String
    @State var image: String
    @State var background: Color
    
    var body: some View {
        HStack(spacing: 10) {
            Image(image)
                .padding(15)
                .frame(width: 60, height: 60)
                .background(background)
                .cornerRadius(16)
            VStack(alignment: .leading, spacing: 13) {
                Text(name)
                    .foregroundColor(.dark25)
                    .font(.system(size: 14))
                Text(description)
                    .foregroundColor(.light20)
                    .font(.system(size: 13))
                    .fontWeight(.semibold)
                    .lineLimit(1)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 13) {
                Text("- $\(value)")
                    .foregroundColor(.red100)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                Text(hour)
                    .foregroundColor(.light20)
                    .font(.system(size: 13))
                    .fontWeight(.semibold)
            }
        }
        .frame(height: 89)
        .padding(.horizontal, 16)
        .background(.light80)
        .cornerRadius(24)
    }
}

#Preview {
    TransactionCellView(name: "Shopping",
                        description: "Buy some grocery",
                        value: "120",
                        hour: "10:00 AM",
                        image: "shopping-bag",
                        background: .yellow20)
}
