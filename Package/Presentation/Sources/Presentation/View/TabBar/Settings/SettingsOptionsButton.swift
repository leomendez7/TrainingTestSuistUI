//
//  SettingsOptionsButton.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import SwiftUI
import Domain

struct SettingsOptionsButton: View {
    
    @State var OptionName = String()
    var name: String
    
    var body: some View {
        HStack {
            Text(OptionName)
                .font(.system(size: 16))
                .fontWeight(.regular)
                .foregroundColor(Color(.dark75))
            Spacer()
            HStack {
                Text(name)
                    .font(.system(size: 16))
                    .fontWeight(.regular)
                    .foregroundColor(Color(.light20))
                Image("arrow-right", bundle: .module)
            }
        }
    }
    
}

#Preview {
    SettingsOptionsButton(OptionName: "Currency", name: "Neither")
}
