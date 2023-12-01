//
//  SecurityOptionsView.swift
//  
//
//  Created by Leonardo Mendez on 9/11/23.
//

import SwiftUI
import Domain

struct SecurityOptionsView: View {
    
    @State var optionName: String
    @Binding var isSecuritySelected: Security
    
    var body: some View {
        HStack {
            Text(optionName)
            Spacer()
            if isSecuritySelected.name == optionName {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 21,height: 21)
                    .foregroundColor(Color(.violet100))
            }
        }
        .onAppear {
            guard let security = Default.security else {
                var security = Security()
                security.name = "Neither"
                isSecuritySelected = security
                return
            }
            isSecuritySelected = security
        }
    }
}

#Preview {
    SecurityOptionsView(optionName: "Neither", isSecuritySelected: .constant(Security()))
}
