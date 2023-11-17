//
//  CreateAccountView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI
import Domain
import Shared

struct CreateAccountView: View {
    
    @State private var name = String()
    @State private var email = String()
    @State private var birthday = String()
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var titleAlert: String = ""
    @State private var textAlert: String = ""
    @StateObject var viewModel: CreateUserViewModel
    
    var backButton: some View {
        Button(action: {
            viewModel.store.login.removeLast()
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
                CustomTextField(text: $email, isEmail: true, placeholder: "Email")
                CustomDateTextField(text: $birthday, placeholder: "Birthday")
                CustomPasswordTextField(password: $password, placeholder: "Password")
            }
            CustomButton(action: {
                if email.isValidEmail {
                    if !name.isEmpty && !email.isEmpty && !password.isEmpty && !birthday.isEmpty {
                        createUser()
                    } else {
                        titleAlert = Localizable.CreateUser.alertTitleEmptyField
                        textAlert = Localizable.CreateUser.alertTextEmptyField
                        showAlert.toggle()
                    }
                } else {
                    titleAlert = Localizable.Email.alertTitleValidateEmail
                    textAlert = Localizable.Email.alertTextValidateEmail
                    showAlert.toggle()
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
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(titleAlert),
                message: Text(textAlert),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func createUser() {
        viewModel.user.name = name
        viewModel.user.email = email
        viewModel.user.birthday = birthday
        viewModel.user.password = password
        Task {
            await viewModel.createUser(user: viewModel.user)
        }
    }

}

#Preview {
    NavigationStack {
        CreateAccountView(viewModel: Constants.createUserViewModel)
    }
}
