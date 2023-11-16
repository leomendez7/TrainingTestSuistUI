//
//  NewTransactionViewModel.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import Foundation
import Combine
import SwiftUI
import Domain

public class NewTransactionViewModel: BaseViewModel<CreateTransactionUseCase>, ObservableObject {
 
    var transaction = Trade()
    @Published var success: Bool = false
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
    
    func showPhotoPicker() {
        if source == .camera {
            if !Picker.checkPermissions() {
                print("There is no camera on this device")
                return
            }
        }
        showPicker = true
    }
    
    func createTransaction(trade: Trade) async {
        do {
            let response = try await useCase.execute(requestValue: trade)
            DispatchQueue.main.async {
                self.success = response
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
}
