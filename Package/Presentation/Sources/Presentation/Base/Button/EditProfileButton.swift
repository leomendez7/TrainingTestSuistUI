//
//  EditProfileButton.swift
//  
//
//  Created by Leonardo Mendez on 24/11/23.
//

import SwiftUI

struct EditProfileButton: View {
    
    var action: () -> Void
    var withoutRounding: Bool
    @State var height: CGFloat?
    @State var width: CGFloat?
    @State var offsetX: CGFloat?
    @State var offsetY: CGFloat?
    
    var body: some View {
        Button(action: {
            action()
        }) {
            if withoutRounding {
                Image("edit-profile-button", bundle: .module)
                    .resizable()
                    .frame(width: width ?? 30, height: height ?? 30)
                    .foregroundColor(.red)
                    .background(Color.white)
                    .overlay(
                        Circle()
                            .stroke(Color.purple, lineWidth: 1)
                    )
                
            } else {
                Image("edit-profile-button", bundle: .module)
                    .resizable()
                    .frame(width: width ?? 30, height: height ?? 30)
            }
        }
        .padding(8)
        .offset(x: offsetX ?? 30, y: offsetY ?? -30)
    }
}

#Preview {
    EditProfileButton(action: {}, withoutRounding: true)
}
