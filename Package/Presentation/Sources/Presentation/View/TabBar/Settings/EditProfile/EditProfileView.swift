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
    
    var body: some View {
        VStack(spacing: 56) {
            VStack(spacing: 14) {
                CustomTextField(text: $name, placeholder: "Name")
                CustomTextField(text: $email, placeholder: "Email")
                CustomDateTextField(text: $birthday, placeholder: "Birthday")
                if let image = viewModel.image {
                    HStack() {
                        CircularImageView(image: image)
                            .onTapGesture {
                                viewModel.source = .library
                                viewModel.showPhotoPicker()
                            }
                        Spacer()
                    }
                } else {
                    Image("add-attachment", bundle: .module)
                        .onTapGesture {
                            viewModel.source = .library
                            viewModel.showPhotoPicker()
                        }
                        .frame(maxWidth: .infinity)
                }
            }
            VStack() {
                CustomButton(action: {
                    updateUser()
                }, text: "Edit", color: Color(.violet100), foregroundColor: .white)
            }
            Spacer()
                .sheet(isPresented: $viewModel.showPicker, content: {
                    ImagePicker(sourceType: viewModel.source == .library
                                ? .photoLibrary : .camera, selectedImage: $viewModel.image)
                    .ignoresSafeArea()
                })
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
            if let image = Default.user()?.imageProfile {
                viewModel.image = UIImage.fromBase64(image)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 64)
        .navigationTitle("Edit profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .navigationBarItems(leading: BackNavigationButton(action: {
            store.settings.removeLast()
        }, image: "arrow-left", color: Color(.dark25)))
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success!"), 
                  message: Text("User has been updated."),
                  primaryButton: .default(Text("Ok"), action: {
                store.settings.removeLast()
            }), secondaryButton: .cancel())
        }
    }
    
    func updateUser() {
        Task {
            await viewModel.updateUser(name: name, email: email, birthday: birthday)
        }
    }
    
}

#Preview {
    NavigationStack {
        EditProfileView(viewModel: Constants.editProfileViewModel)
    }
}
