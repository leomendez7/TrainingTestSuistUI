//
//  CreateUserViewModel.swift
//
//
//  Created by Leonardo Mendez on 10/11/23.
//

import Foundation
import Combine
import SwiftUI
import Domain

public class CreateUserViewModel: BaseViewModel<CreateUserUseCase>, ObservableObject {
    
    var user = User()
    @Published var success: Bool = false
    
    func createUser(user: User) async {
        do {
            let response = try await useCase.execute(requestValue: user)
            DispatchQueue.main.async {
                self.success = response
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
}

