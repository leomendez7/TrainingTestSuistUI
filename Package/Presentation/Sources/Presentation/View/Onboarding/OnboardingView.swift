//
//  OnboardingView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 30/10/23.
//

import SwiftUI
import Domain

public struct OnboardingView: View {
    
    @StateObject private var manager = OnboardingManager()
    @State private var showLoginButton = false
    @State private var showNextAndSkipButton = true
    @State private var selectedTab = 0
    @State private var isLoggedIn = false
    @EnvironmentObject var store: Store
    @EnvironmentObject var setDefault: Default
    
    public init() {
        showLoginButton = true
        showNextAndSkipButton = true
        selectedTab = 0
        isLoggedIn = false
    }
    
    public var body: some View {
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
                            setDefault.onboarding = true
                        }, text: "Login", color: Color(.violet100), foregroundColor: .white)
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
                            }, text: "Next", color: Color(.violet100), foregroundColor: .white)
                            CustomButton(action: {
                                setDefault.onboarding = true
                            }, text: "Skip", color: Color(.violet20), foregroundColor: Color(.violet100))
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
                default:
                    EmptyView()
                }
            })
        }
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "violet-100")
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(named: "violet-20")
    }
}

#Preview {
    OnboardingView()
        .environmentObject(Store())
}
