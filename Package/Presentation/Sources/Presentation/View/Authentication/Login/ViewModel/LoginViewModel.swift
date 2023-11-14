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
    
    @Published var user: User? = nil
    @Published var success: Bool = false
    
    func fetchUser(email: String) async {
        do {
            let response = try await useCase.execute(requestValue: email)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
}
