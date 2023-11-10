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
                    .foregroundColor(Color("violet-100", bundle: .module))
            }
        }
        .onAppear {
            if Default.security().name.isEmpty {
                var security = Security()
                security.name = "PIN"
                isSecuritySelected = security
            } else {
                isSecuritySelected = Default.security()
            }
        }
    }
}

#Preview {
    SecurityOptionsView(optionName: "PIN", isSecuritySelected: .constant(Security()))
}
