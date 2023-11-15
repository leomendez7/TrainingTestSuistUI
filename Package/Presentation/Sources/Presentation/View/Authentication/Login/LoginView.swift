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
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @EnvironmentObject var store: Store
    @EnvironmentObject var setDefault: Default
    @EnvironmentObject var viewModel: LoginViewModel
    @State private var cancellables: Set<AnyCancellable> = []
    
    public init() {
        email = ""
        password = ""
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
                        signIn(email: email)
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
                    CreateAccountView()
                default:
                    EmptyView()
                }
            })
            .navigationTitle("Login")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.$success.sink { response in
                    if response {
                        setDefault.session = true
                    }
                }.store(in: &cancellables)
                viewModel.$alert.sink { response in
                    if response {
                        showAlert.toggle()
                    }
                }.store(in: &cancellables)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(Localizable.Login.alertTitleValidateUser),
                    message: Text(Localizable.Login.alertTextValidateUser),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    func signIn(email: String) {
        Task {
            let credentials = ["email": email, "password": password]
            await viewModel.Login(credentials: credentials)
        }
    }
    
}

#Preview {
    LoginView()
        .environmentObject(Store())
        .environmentObject(Default())
}
