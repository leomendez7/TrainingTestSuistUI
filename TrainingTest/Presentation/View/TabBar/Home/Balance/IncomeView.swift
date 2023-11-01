//
//  IncomeView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI

struct IncomeView: View {
    
    @State var income: String = ""
    
    var body: some View {
        HStack(spacing: 10) {
            HStack {
                Image("income")
                    .padding(8)
            }
            .frame(width: 48, height: 48)
            .background(.white)
            .cornerRadius(16)
            VStack(alignment: .leading, spacing: 4) {
                Text("Income")
                    .foregroundColor(.white)
                    .font(.system(size: 14))
                    
                Text("$\(income)")
                    .foregroundColor(.white)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
            }
        }
        .frame(height: 80)
        .frame(width: 164)
        .background(.green100)
        .cornerRadius(28)
    }
}

#Preview {
    IncomeView(income: "5000")
}
