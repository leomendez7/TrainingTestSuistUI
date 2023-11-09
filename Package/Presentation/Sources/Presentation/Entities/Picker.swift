//
//  Picker.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import UIKit

enum Picker {
   
    enum Source: String {
        case library, camera
    }
    
    static func checkPermissions() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            return true
        } else {
            return false
        }
    }
    
}
