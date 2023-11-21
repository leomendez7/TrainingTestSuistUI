//
//  SwiftUIView.swift
//  
//
//  Created by Leonardo Mendez on 20/11/23.
//

import SwiftUI

struct TransactionDetailsDescriptionView: View {
    
    @Binding var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Image("discontinue-lines", bundle: .module)
            Text("Description")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(Color(.light20))
            Text(description)
                .font(.system(size: 16))
                .foregroundColor(Color(.dark))
            Spacer()
        }
        .padding(.top, 57)
    }
    
}

#Preview {
    TransactionDetailsDescriptionView(description: .constant(""))
}
