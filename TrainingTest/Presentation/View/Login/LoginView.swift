//
//  LoginView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack(spacing: 56) {
            VStack(spacing: 64) {
                Text("Login")
                    .fontWeight(.bold)
                    .font(.system(size: 18))
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
                    store.onboarding.append("TabBarView")
                }, text: "Sing in", color: .violet100, foregroundColor: .white)
                CustomButton(action: {
                    store.onboarding.append("CreateAccountView")
                }, text: "Create Account", color: .white, foregroundColor: .black)
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginView()
}
