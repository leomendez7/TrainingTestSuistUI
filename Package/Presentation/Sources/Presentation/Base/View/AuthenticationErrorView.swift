//
//  AuthenticationErrorView.swift
//
//
//  Created by Leonardo Mendez on 30/11/23.
//

import SwiftUI
import Shared
import LocalAuthentication

public struct AuthenticationErrorView: View {
    
    @State private var authenticationSuccess = false
    
    public init(){}
    
    public var body: some View {
        Group {
            if authenticationSuccess {
                TabBarView()
            } else {
                VStack {
                    Text("Unlock Expenses with your Face ID")
                        .textModifierStyle(size: 16, color: Color(.dark), weight: .semibold)
                        .padding()
                    Image("face-id", bundle: .module)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .onTapGesture {
                            authenticateWithFaceID()
                        }
                    .padding()
                }
                .onAppear {
                    authenticateWithFaceID()
                }
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
            }
        }
    }
    
}

#Preview {
    AuthenticationErrorView()
}
