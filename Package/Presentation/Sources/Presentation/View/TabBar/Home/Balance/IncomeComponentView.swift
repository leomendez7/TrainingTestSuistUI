//
//  IncomeComponentView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI

struct IncomeComponentView: View {
    
    @State var income: String = ""
    
    var body: some View {
        HStack(spacing: 10) {
            Image("income", bundle: .module)
                .padding(8)
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
        .frame(width: 164, height: 80)
        .background(Color("green-100", bundle: .module))
        .cornerRadius(28)
    }
}

#Preview {
    IncomeComponentView(income: "5000")
}
