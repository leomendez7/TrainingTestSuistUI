//
//  LoginView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

public struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var store: Store
    @EnvironmentObject var setDefault: Default
    
    public init() {
        email = ""
        password = ""
    }
    
    public var body: some View {
        NavigationStack(path: $store.login) {
            VStack(spacing: 56) {
                VStack(spacing: 64) {
                    VStack(spacing: 14) {
                        CustomTextField(text: email, placeholder: "Email")
                        CustomPasswordTextField(password: password, placeholder: "Password")
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                }
                .padding(.top, 16)
                VStack(spacing: 16) {
                    CustomButton(action: {
                        setDefault.session = true
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
        }
    }
    
}

#Preview {
    LoginView()
        .environmentObject(Store())
        .environmentObject(Default())
}
