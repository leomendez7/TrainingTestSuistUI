//
//  EditProfileView.swift
//
//
//  Created by Leonardo Mendez on 10/11/23.
//

import SwiftUI
import Domain
import Shared
import Combine

struct EditProfileView: View {
    
    @EnvironmentObject var store: Store
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var birthday: String = ""
    @State private var showAlert = false
    @StateObject var viewModel: EditProfileViewModel
    @State private var cancellables: Set<AnyCancellable> = []
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
                CustomTextField(text: $name, placeholder: "Name")
                CustomTextField(text: $email, placeholder: "Email")
                CustomDateTextField(text: $birthday, placeholder: "Birthday")
                Button(action:{
                    
                }) {
                    Image("add-attachment", bundle: .module)
                }
            }
            VStack() {
                CustomButton(action: {
                    updateUser()
                }, text: "Edit", color: Color(.violet100), foregroundColor: .white)
            }
            Spacer()
        }
        .onReceive(viewModel.$success) { newValue in
            if newValue {
                showAlert.toggle()
            }
        }
        .onAppear {
            email = Default.user()?.email ?? ""
            name = Default.user()?.name ?? ""
            birthday = Default.user()?.birthday ?? ""
        }
        .padding(.horizontal, 16)
        .padding(.top, 64)
        .navigationTitle("Edit profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: backButton)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success!"), 
                  message: Text("User has been updated."),
                  primaryButton: .default(Text("Ok"), action: {
                store.settings.removeLast()
            }), secondaryButton: .cancel())
        }
    }
    
    func updateUser() {
        viewModel.user = Default.user() ?? User()
        viewModel.user.name = name
        viewModel.user.email = email
        viewModel.user.birthday = birthday
        Task {
            await viewModel.updateUser(user: viewModel.user)
        }
    }
}

#Preview {
    NavigationStack {
        EditProfileView(viewModel: Constants.editProfileViewModel)
    }
}
