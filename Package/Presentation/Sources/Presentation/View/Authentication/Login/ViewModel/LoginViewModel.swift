//
//  LoginViewModel.swift
//  
//
//  Created by Leonardo Mendez on 13/11/23.
//

import Foundation
import Combine
import SwiftUI
import Domain

public class LoginViewModel: BaseViewModel<FetchUserUseCase>, ObservableObject {
    
    @Published var success: Bool = false
    @Published var alert: Bool = false
    
    func fetchUser(credentials: [String: String]) async {
        do {
            let user = try await useCase.execute(requestValue: credentials)
            DispatchQueue.main.async {
                if user.email.isEmpty {
                    self.alert = true
                } else {
                    Default.save(user: user)
                    self.success = true
                }
            }
        } catch {
            success = false
            debugPrint(error.localizedDescription)
        }
    }
    
}
