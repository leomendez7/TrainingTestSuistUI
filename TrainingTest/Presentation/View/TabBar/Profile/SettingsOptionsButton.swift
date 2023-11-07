//
//  SettingsOptionsButton.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import SwiftUI

struct SettingsOptionsButton: View {
    
    var action: () -> Void
    @State var OptionName = String()
    @Binding var name: String
    
    var body: some View {
        HStack {
            Text(OptionName)
                .font(.system(size: 16))
                .fontWeight(.regular)
                .foregroundColor(.dark75)
            Spacer()
            HStack {
                Text(name)
                    .font(.system(size: 16))
                    .fontWeight(.regular)
                    .foregroundColor(.light20)
                Button(action: {
                    action()
                }) {
                    Image("arrow-right")
                }
                .frame(width: 15)
            }
        }
    }
    
}

#Preview {
    SettingsOptionsButton(action: {}, name: .constant(String()))
}
