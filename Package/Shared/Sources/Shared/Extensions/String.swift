//
//  String.swift
//
//
//  Created by Leonardo Mendez on 14/11/23.
//

import Foundation

public extension String {
    
    var isValidEmail: Bool {
        var validEmail = true
        var emailRegEx = "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" + "\\@" + "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"
        emailRegEx += "(" + "\\." + "[a-zA-Z0-9][a-zA-Z0-9\\-]{1,25}" + ")+"
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            if results.isEmpty || contains(" ") {
                validEmail = false
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            validEmail = false
        }
        return validEmail
    }
    
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", comment: "")
    }
    
}
