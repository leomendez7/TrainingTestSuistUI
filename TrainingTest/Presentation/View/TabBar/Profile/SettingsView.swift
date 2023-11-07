//
//  SettingsView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var store: Store
    @State private var isSheetPresented = false
    @State var currencyName = String()
    @State var securityName = String()
    @State var name = String()
    @State var email = String()
    
    var body: some View {
        VStack {
            HStack(spacing: 19) {
                Image("avatar-2")
                    .frame(width: 80, height: 80)
                DataProfileView(email: $email, name: $name)
                    .onAppear {
                        email = "irina@mail.com"
                        name = "Irina Saliha"
                    }
                Spacer()
                Button(action: {
                }) {
                    Image("edit-profile-button")
                }
            }
            VStack(spacing: 47) {
                VStack(spacing: 20) {
                    SettingsOptionsButton(action: {
                        store.onboarding.append("Currency")
                    }, OptionName: "Currency", name: $currencyName)
                    SettingsOptionsButton(action: {
                        store.onboarding.append("Security")
                    }, OptionName: "Security", name: $securityName)
                }
                .onAppear {
                    currencyName = Default.currency()
                    securityName = Default.security()
                }
                Button(action: {
                    isSheetPresented.toggle()
                }, label: {
                    Text("Log out")
                        .foregroundColor(.dark75)
                })
                .sheet(isPresented: $isSheetPresented) {
                    LogoutView(isSheetPresented: isSheetPresented)
                        .presentationDetents([.fraction(0.25)])
                }
            }
            .padding(.top, 45)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 14)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "logout"))) { _ in
            store.settings.append("Logout")
        }
    }
    
}

#Preview {
    SettingsView()
        .environmentObject(Store())
}
