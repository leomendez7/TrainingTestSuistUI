//
//  UserViewModel.swift
//
//
//  Created by Leonardo Mendez on 10/11/23.
//

import Foundation
import Combine
import SwiftUI
import Domain

public class UserViewModel: BaseViewModel<CreateUserUseCase>, ObservableObject {
    
    @Published var user: User? = nil
    @Published var success: Bool = false
    
    func createUser(user: User) async {
        do {
            let response = try await useCase.execute(requestValue: user)
            success = response
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
}

public struct BaseView<ViewModel>: View {
    
    var viewModel: ViewModel
    
    public init?(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Text("")
    }
    
}
