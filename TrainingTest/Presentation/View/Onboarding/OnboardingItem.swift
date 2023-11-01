//
//  OnboardingItem.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 30/10/23.
//

import Foundation

struct OnboardingItem: Identifiable {
    let id: Int
    let image: String
    let title: String
    let content: String
}

extension OnboardingItem: Equatable {}

final class OnboardingManager: ObservableObject {
    
    @Published private(set) var items: [OnboardingItem] = []
    
    func load() {
        items = [
            .init(id: 0,
                  image: "Onboarding-1",
                  title: "Gain total control of your money",
                  content: "Become your own money manager and make every cent count"),
            .init(id: 1,
                  image: "Onboarding-2",
                  title: "Know where your money goes",
                  content: "Track your transaction easily,           with categories and financial report"),
            .init(id: 2, 
                  image: "Onboarding-3",
                  title: "Planning ahead",
                  content: "Setup your budget for each category so you in control")]
    }
    
}
