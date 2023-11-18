//
//  LogoutView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 7/11/23.
//

import SwiftUI
import Domain

struct ConfirmationView: View {
    
    @State var isSheetPresented: Bool
    @State var title: String
    @State var bodyText: String
    @Binding var activeAction: Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack(spacing: 20) {
            Image("line", bundle: .module)
                .padding(.top, 16)
            VStack(spacing: 16) {
                Text(title)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                Text(bodyText)
                    .font(.system(size: 16))
                    .fontWeight(.regular)
                    .foregroundColor(Color(.light20))
                    .lineLimit(0)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            HStack(spacing: 16) {
                CustomButton(action: {
                    dismiss()
                }, text: "No", color: Color(.violet20), foregroundColor: Color(.violet100), width: 164)
                CustomButton(action: {
                    activeAction.toggle()
                    dismiss()
                }, text: "Yes", color: Color(.violet100), foregroundColor: .white, width: 164)
            }
        }
        .background(Color.white)
        .cornerRadius(16)
    }
}

#Preview {
    ConfirmationView(isSheetPresented: true,
               title: "Log out",
               bodyText: "Are you sure you want to log out?",
               activeAction: .constant(true))
}
