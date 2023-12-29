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
    @State private var isSheetPresented = false
    @State private var authenticationSuccess = false
    @State private var cancelPin = false
    
    var body: some View {
        VStack(spacing: 24) {
            ForEach(viewModel.securities.indices, id: \.self) { index in
                SecurityOptionsView(optionName: viewModel.securities[index].name,
                                    isSecuritySelected: $isSelectedSecurity)
                .onTapGesture {
                    OldSecurity = isSelectedSecurity
                    isSelectedSecurity = viewModel.securities[index]
                    
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
            case .pin:
                isSheetPresented.toggle()
            case .biometric:
                authenticateWithFaceID()
            case .neither:
                Default.save(security: viewModel.securities[0])
            }
        }
        .onChange(of: cancelPin) { newValue in
            if newValue {
                store.settings.removeLast()
            }
        }
        .fullScreenCover(isPresented: $isSheetPresented) {
            PinView(isInitial: false, cancelPin: $cancelPin)
        }
    }
    
    private func authenticateWithFaceID() {
        AuthenticationManager.shared.authenticateWithFaceID { success, error in
            if success {
                authenticationSuccess = true
                Default.save(security: viewModel.securities[2])
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
                        store.settings.removeLast()
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
