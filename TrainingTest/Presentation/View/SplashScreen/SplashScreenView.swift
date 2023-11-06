//
//  SplashScreenView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 30/10/23.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            let session = Default.session()
            if session {
                TabBarView()
            } else {
                OnboardingView()
            }
        } else {
            ZStack {
                Color(.violet100)
                    .ignoresSafeArea()
                ZStack {
                    Image("Ellipse")
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 74, height: 74)
                        .offset(x: -30)
                    Text("Expenses")
                        .font(.system(size: 56))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeInOut) {
                        isActive.toggle()
                    }                 }
            }
        }
    }
    
}

#Preview {
    SplashScreenView()
}
