//
//  SettingsView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var store: Store
    @State var currencyName = String()
    @State var securityName = String()
    
    var body: some View {
        NavigationStack(path: $store.settings) {
            VStack {
                HStack(spacing: 19) {
                    Image("avatar-2")
                        .frame(width: 80, height: 80)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("email@email")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(.light20)
                        Text("Irina Saliha")
                            .font(.system(size: 24))
                            .fontWeight(.bold)
                            .foregroundColor(.dark75)
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
                        store.onboarding.append("Logout")
                    }, label: {
                        Text("Log out")
                            .foregroundColor(.dark75)
                    })
                }
                .padding(.top, 45)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 14)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationDestination(for: String.self, destination: { route in
            switch route {
            case "Currency":
                CurrencyView()
                    .environmentObject(CurrencyViewModel())
            case "Security":
                CreateAccountView()
            case "Logout":
                LoginView()
            default:
                EmptyView()
            }
        })
    }
    
}

#Preview {
    SettingsView()
        .environmentObject(Store())
}
