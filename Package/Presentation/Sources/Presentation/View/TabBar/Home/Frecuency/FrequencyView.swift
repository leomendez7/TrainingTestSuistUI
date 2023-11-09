//
//  FrequencyView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 1/11/23.
//

import SwiftUI

struct FrequencyView: View {
   
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Spend Frequency")
                .foregroundColor(Color("dark", bundle: .module))
                .font(.system(size: 18))
                .fontWeight(.bold)
            Image("graph", bundle: .module)
            SelectFrequencyView()
        }
        .padding(.top, 31)
    }
}

#Preview {
    FrequencyView()
}
