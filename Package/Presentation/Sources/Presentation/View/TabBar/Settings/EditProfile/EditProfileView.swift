//
//  EditProfileView.swift
//
//
//  Created by Leonardo Mendez on 10/11/23.
//

import SwiftUI

struct EditProfileView: View {
    
    @EnvironmentObject var store: Store
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var birthday: String = ""
    
    var backButton : some View {
        Button(action: {
            store.settings.removeLast()
        }) {
            HStack {
                Image("arrow-left", bundle: .module)
                    .foregroundColor(Color(.dark25))
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 56) {
            VStack(spacing: 14) {
                CustomTextField(text: name, placeholder: "Name")
                CustomTextField(text: email, placeholder: "Email")
                CustomDateTextField(placeholder: "Birthday")
                Button(action:{
                    
                }) {
                    Image("add-attachment", bundle: .module)
                }
            }
            VStack() {
                CustomButton(action: {
                    
                }, text: "Edit", color: Color(.violet100), foregroundColor: .white)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 64)
        .navigationTitle("Edit profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: backButton)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    NavigationStack {
        EditProfileView()
    }
}
