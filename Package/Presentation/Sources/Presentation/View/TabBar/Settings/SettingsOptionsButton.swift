//
//  SettingsOptionsButton.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import SwiftUI

struct SettingsOptionsButton: View {
    
    @State var OptionName = String()
    @Binding var name: String
    
    var body: some View {
        HStack {
            Text(OptionName)
                .font(.system(size: 16))
                .fontWeight(.regular)
                .foregroundColor(Color("dark-75", bundle: .module))
            Spacer()
            HStack {
                Text(name)
                    .font(.system(size: 16))
                    .fontWeight(.regular)
                    .foregroundColor(Color("light-20", bundle: .module))
                Image("arrow-right", bundle: .module)
            }
        }
    }
    
}

#Preview {
    SettingsOptionsButton(OptionName: "Currency", name: .constant("USD"))
}
