//
//  NewTransactionViewModel.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import Foundation
import Combine
import SwiftUI

public class NewTransactionViewModel: ObservableObject {
 
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
    
}
