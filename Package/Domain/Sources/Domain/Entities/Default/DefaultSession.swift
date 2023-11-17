//
//  DefaultSession.swift
//
//
//  Created by Leonardo Mendez on 17/11/23.
//

import Foundation
import SwiftUI

public class DefaultSession: ObservableObject {
    
    @AppStorage("appStorageOnboarding") public var onboarding = Bool()
    @AppStorage("appStorageSession") public var session = Bool()
    
    public init() { }

}
