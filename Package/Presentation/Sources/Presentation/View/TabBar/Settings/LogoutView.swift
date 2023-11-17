//
//  LogoutView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 7/11/23.
//

import SwiftUI
import Domain

struct LogoutView: View {
    
    @State var isSheetPresented: Bool
    @Binding var isLogout: Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack(spacing: 20) {
            Image("line", bundle: .module)
                .padding(.top, 16)
            VStack(spacing: 16) {
                Text("Log out")
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Text("Are you sure you want to log out?")
                    .font(.system(size: 16))
                    .fontWeight(.regular)
                    .foregroundColor(Color(.light20))
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            HStack(spacing: 16) {
                CustomButton(action: {
                    dismiss()
                }, text: "No", color: Color(.violet20), foregroundColor: Color(.violet100), width: 164)
                CustomButton(action: {
                    isLogout.toggle()
                    dismiss()
                }, text: "Yes", color: Color(.violet100), foregroundColor: .white, width: 164)
            }
        }
        .background(Color.white)
        .cornerRadius(16)
    }
}

#Preview {
    LogoutView(isSheetPresented: true, isLogout: .constant(true))
}
