//
//  SecurityOptionsView.swift
//  
//
//  Created by Leonardo Mendez on 9/11/23.
//

import SwiftUI
import Domain

struct SecurityOptionsView: View {
    
    @State var optionName: SecurityName
    @Binding var isSecuritySelected: Security
    
    var body: some View {
        HStack {
            Text(optionName.rawValue)
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
                security.name = .neither
                isSecuritySelected = security
                return
            }
            isSecuritySelected = security
        }
    }
}

#Preview {
    SecurityOptionsView(optionName: .neither, isSecuritySelected: .constant(Security()))
}
