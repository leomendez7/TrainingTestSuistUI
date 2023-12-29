//
//  AuthenticationManager.swift
//
//
//  Created by Leonardo Mendez on 30/11/23.
//

import Foundation
import LocalAuthentication

public class AuthenticationManager {
    
    public static let shared = AuthenticationManager()
    
    public init() {}

    public func authenticateWithFaceID(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authentication required to access the application."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    completion(success, authenticationError)
                }
            }
        } else {
            completion(false, error)
        }
    }
    
}
