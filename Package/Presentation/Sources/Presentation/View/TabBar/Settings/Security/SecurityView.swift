//
//  SecurityView.swift
//
//
//  Created by Leonardo Mendez on 9/11/23.
//

import SwiftUI
import Domain
import Shared
import LocalAuthentication

struct SecurityView: View {
    
    @EnvironmentObject var viewModel: SecurityViewModel
    @EnvironmentObject var store: Store
    @State var isSelectedSecurity = Security()
    @State var OldSecurity = Security()
    @State private var authenticationSuccess = false
    
    var body: some View {
        VStack(spacing: 24) {
            ForEach(viewModel.securities.indices, id: \.self) { index in
                SecurityOptionsView(optionName: viewModel.securities[index].name,
                                    isSecuritySelected: $isSelectedSecurity)
                .onTapGesture {
                    OldSecurity = isSelectedSecurity
                    isSelectedSecurity = viewModel.securities[index]
                    Default.save(security: viewModel.securities[index])
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .navigationTitle("Security")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .navigationBarItems(leading: BackNavigationButton(action: {
            store.settings.removeLast()
        }, image: "arrow-left", color: Color(.dark25)))
        .task {
            viewModel.generateSecurities()
        }
        .onChange(of: isSelectedSecurity.name) { newValue in
            switch newValue {
            case "PIN":
                print("pin")
            case "Biometric Authentication":
                authenticateWithFaceID()
            case "Neither":
                print("nothing")
            default:
                print("default")
            }
        }
    }
    
    private func authenticateWithFaceID() {
        AuthenticationManager.shared.authenticateWithFaceID { success, error in
            if success {
                authenticationSuccess = true
            } else {
                if let error = error as? LAError {
                    print("Error: \(error.localizedDescription)")
                }
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Authentication Error!",
                                                            message: "There was a problem with authentication.",
                                                            preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Try again", style: .default) { _ in
                        authenticateWithFaceID()
                    })
                    alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive) { _ in
                        isSelectedSecurity = OldSecurity
                        Default.save(security: OldSecurity)
                    })
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        if let rootViewController = windowScene.windows.first?.rootViewController {
                            rootViewController.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
}

#Preview {
    SecurityView()
        .environmentObject(Store())
        .environmentObject(SecurityViewModel())
}
