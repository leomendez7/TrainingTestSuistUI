//
//  LoginView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI
import Domain
import Combine
import Shared

public struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var showAlert = false
    @EnvironmentObject var store: Store
    @EnvironmentObject var setDefault: Default
    @StateObject var viewModel: LoginViewModel
    
    public init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationStack(path: $store.login) {
            VStack(spacing: 56) {
                VStack(spacing: 64) {
                    VStack(spacing: 14) {
                        CustomTextField(text: $email, isEmail: true, placeholder: "Email")
                        CustomPasswordTextField(password: $password, placeholder: "Password")
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                }
                .padding(.top, 16)
                VStack(spacing: 16) {
                    CustomButton(action: {
                        signIn(email: email, password: password)
                    }, text: "Sing in", color: Color(.violet100), foregroundColor: .white)
                    CustomButton(action: {
                        store.login.append("createAccountView")
                    }, text: "Create Account", color: .white, foregroundColor: .black)
                }
                Spacer()
            }
            .navigationDestination(for: String.self, destination: { route in
                switch route {
                case "createAccountView":
                    CreateAccountView(viewModel: Constants.createUserViewModel)
                default:
                    EmptyView()
                }
            })
            .navigationTitle("Login")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(Localizable.Login.alertTitleValidateUser),
                    message: Text(Localizable.Login.alertTextValidateUser),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .onReceive(viewModel.$success) { newValue in
            if newValue {
                setDefault.session = true
            }
        }
        .onReceive(viewModel.$alert) { newValue in
            if newValue {
                showAlert.toggle()
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Task {
            let credentials = ["email": email, "password": password]
            await viewModel.Login(credentials: credentials)
        }
    }
    
}

#Preview {
    LoginView(viewModel: Constants.loginViewModel)
        .environmentObject(Store())
        .environmentObject(Default())
}
