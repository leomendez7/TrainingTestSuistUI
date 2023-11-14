//
//  SettingsView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import SwiftUI
import Domain

struct SettingsView: View {
    
    @EnvironmentObject var store: Store
    @EnvironmentObject var setDefault: Default
    @State private var isSheetPresented = false
    @State var currencyName = String()
    @State var securityName = String()
    @State var name = String()
    @State var email = String()
    
    var body: some View {
        NavigationStack(path: $store.settings) {
            VStack {
                HStack(spacing: 19) {
                    Image("avatar-2", bundle: .module)
                        .frame(width: 80, height: 80)
                    DataProfileView(email: $email, name: $name)
                    Spacer()
                    Button(action: {
                        store.settings.append("editProfile")
                    }) {
                        Image("edit-profile-button", bundle: .module)
                    }
                }
                VStack(spacing: 47) {
                    VStack(spacing: 20) {
                        SettingsOptionsButton(OptionName: "Currency", name: $currencyName)
                            .onTapGesture {
                                store.settings.append("currency")
                            }
                        SettingsOptionsButton(OptionName: "Security", name: $securityName)
                            .onTapGesture {
                                store.settings.append("security")
                            }
                    }
                    .onAppear {
                        let abbreviation = Default.currency().abbreviation.isEmpty
                        let securityName = Default.security().name.isEmpty
                        currencyName = abbreviation ? "USD" : Default.currency().abbreviation
                        self.securityName = securityName ? "PIN" : Default.security().name
                    }
                    Button(action: {
                        isSheetPresented.toggle()
                    }, label: {
                        Text("Log out")
                            .foregroundColor(Color(.dark75))
                    })
                    .sheet(isPresented: $isSheetPresented) {
                        LogoutView(isSheetPresented: isSheetPresented)
                            .presentationDetents([.fraction(0.25)])
                    }
                }
                .padding(.top, 45)
                Spacer()
            }
            .navigationDestination(for: String.self, destination: { route in
                switch route {
                case "currency":
                    CurrencyView()
                case "security":
                    SecurityView()
                case "editProfile":
                    EditProfileView()
                default:
                    EmptyView()
                }
            })
            .onAppear {
                email = Default.user().email
                name = Default.user().name
            }
            .padding(.horizontal, 16)
            .padding(.top, 14)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "logout"))) { _ in
                setDefault.session = false
            }
        }
    }
    
}

#Preview {
    SettingsView()
        .environmentObject(Store())
        .environmentObject(Default())
}
