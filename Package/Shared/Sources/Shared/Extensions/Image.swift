//
//  File.swift
//  
//
//  Created by Leonardo Mendez on 21/11/23.
//

import UIKit

extension UIImage {
    
    public func toBase64() -> String? {
        if let imageData = self.jpegData(compressionQuality: 1.0) {
            return imageData.base64EncodedString()
        }
        return nil
    }

   public static func fromBase64(_ base64String: String) -> UIImage? {
        if let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
            return UIImage(data: imageData)
        }
        return nil
    }
    
}
