//
//  OnboardingView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 30/10/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject private var manager = OnboardingManager()
    @State private var showLoginButton = false
    @State private var showNextAndSkipButton = true
    @State private var selectedTab = 0
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            VStack() {
                if !manager.items.isEmpty {
                    TabView(selection: $selectedTab) {
                        ForEach(manager.items.indices, id: \.self) { index in
                            OnboardingInfoView(item: manager.items[index])
                                .onAppear {
                                    showLoginButton = index == 2
                                    showNextAndSkipButton = index != 2
                                }
                        }
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(.page)
                    .onAppear {
                        setupAppearance()
                    }
                    if showLoginButton {
                        CustomButton(action: {
                            isLoggedIn = true
                        }, text: "Login", color: .violet100, foregroundColor: .white)
                        CustomButton(action: {}, text: "", color: .white, foregroundColor: .white)
                    }
                    if showNextAndSkipButton {
                        VStack(spacing: 16) {
                            CustomButton(action: {
                                withAnimation {
                                    if selectedTab < manager.items.count - 1 {
                                        selectedTab += 1
                                    }
                                }
                            }, text: "Next", color: .violet100, foregroundColor: .white)
                            CustomButton(action: {
                                isLoggedIn = true
                            }, text: "Skip", color: .violet20, foregroundColor: .violet100)
                        }
                    }
                    Spacer()
                }
            }
            .onAppear() {
                manager.load()
            }
            .navigationDestination(isPresented: $isLoggedIn, destination: { LoginView() })
        }
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .violet100
        UIPageControl.appearance().pageIndicatorTintColor = .violet20
    }
}

#Preview {
    OnboardingView()
}
