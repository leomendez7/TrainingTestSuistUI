//
//  CreateAccountView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI
import Domain

struct CreateAccountView: View {
    
    @State private var name = String()
    @State private var email = String()
    @State private var birthday: String = ""
    @State private var password: String = ""
    @EnvironmentObject var store: Store
    @EnvironmentObject var viewModel: CreateUserViewModel
    
    var backButton: some View {
        Button(action: {
            store.login.removeLast()
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
                CustomTextField(text: $name, placeholder: "Name")
                CustomTextField(text: $email, placeholder: "Email")
                CustomDateTextField(placeholder: "Birthday")
                CustomPasswordTextField(password: password, placeholder: "Password")
            }
            CustomButton(action: {
                if name.isEmpty {
                    print("yes is empty")
                }
                print("\(name) \(email)")
                viewModel.user.name = name
                viewModel.user.email = email
                Task {
                    await viewModel.createUser(user: viewModel.user)
                }
            }, text: "Sing up", color: Color(.violet100), foregroundColor: .white)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 64)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .navigationTitle("Create Account")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CreateAccountView()
            .environmentObject(Store())
    }
}
