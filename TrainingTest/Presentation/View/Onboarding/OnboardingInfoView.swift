//
//  OnboardingInfoView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 30/10/23.
//

import SwiftUI

struct OnboardingInfoView: View {
    
    let item: OnboardingItem
    
    var body: some View {
        VStack {
            Image(item.image)
                .aspectRatio(contentMode: .fit)
                .frame(width: 312, height: 312)
            Text(item.title)
                .font(.system(size: 32))
                .foregroundColor(.dark50)
                .fontWeight(.bold)
                .padding(EdgeInsets(top: 0, leading: 47, bottom: 16, trailing: 47))
                .multilineTextAlignment(.center)
            Text(item.content)
                .font(.system(size: 16))
                .foregroundColor(.light20)
                .fontWeight(.bold)
                .padding(EdgeInsets(top: 0, leading: 47, bottom: 0, trailing: 47))
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    OnboardingInfoView(item: .init(id: 1, 
                                   image: "Onboarding-1",
                                   title: "Gain total control of your money",
                                   content: "Become your own money manager and make every cent count"))
    .previewLayout(.sizeThatFits)
    
}
