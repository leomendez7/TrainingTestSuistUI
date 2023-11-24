//
//  CustomAlertView.swift
//
//
//  Created by Leonardo Mendez on 22/11/23.
//

import SwiftUI

struct CustomAlertView: View {
    
    @Binding var isPresented: Bool
    var action: () -> Void
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            VStack(spacing: 16) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .foregroundColor(Color(.violet100))
                Text("Transaction has been successfully added")
                    .textModifierStyle(size: 16, color: Color(.dark), weight: .regular)
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(12)
        }
        .opacity(isPresented ? 1 : 0)
    }
    
}
