//
//  EditProfileViewModel.swift
//
//
//  Created by Leonardo Mendez on 14/11/23.
//

import Foundation
import Combine
import SwiftUI
import Domain

public class EditProfileViewModel: BaseViewModel<UpdateUserUseCase>, ObservableObject {
    
    var user = User()
    @Published var success: Bool = false
    @Published var alert: Bool = false
    
    func updateUser(user: User) async {
        do {
            let user = try await useCase.execute(requestValue: user)
            DispatchQueue.main.async {
                if user.name.isEmpty {
                    self.alert = true
                } else {
                    let defaults = UserDefaults.standard
                    defaults.removeObject(forKey: Default.Key.user.rawValue)
                    Default.save(user: user)
                    self.success = true
                }
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
}
