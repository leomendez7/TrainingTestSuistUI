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
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationStack(path: $store.onboarding) {
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
                            store.onboarding.append("login")
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
                                store.onboarding.append("login")
                            }, text: "Skip", color: .violet20, foregroundColor: .violet100)
                        }
                    }
                    Spacer()
                }
            }
            .onAppear() {
                manager.load()
            }
            .navigationDestination(for: String.self, destination: { route in
                switch route {
                case "login":
                    LoginView()
                case "CreateAccountView":
                    CreateAccountView()
                case "TabBarView":
                    TabBarView()
                default:
                    EmptyView()
                }
            })
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
