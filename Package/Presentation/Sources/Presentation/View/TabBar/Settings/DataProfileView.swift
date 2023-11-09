//
//  DataProfileView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 7/11/23.
//

import SwiftUI

struct DataProfileView: View {
    
    @Binding var email: String
    @Binding var name: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(email)
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .foregroundColor(Color("light-20", bundle: .module))
            Text(name)
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundColor(Color("dark-75", bundle: .module))
        }
    }
}

#Preview {
    DataProfileView(email: .constant("email@email"), name: .constant("Irina Saliha"))
}
