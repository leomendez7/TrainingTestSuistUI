//
//  SelectedButtonView.swift
//
//
//  Created by Leonardo Mendez on 28/11/23.
//

import SwiftUI

struct SelectedButtonView: View {
    
    var action: () -> Void
    var text: String
    var foregroundColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Button(text) {
            action()
        }
        .font(.system(size: 14))
        .fontWeight(.regular)
        .foregroundColor(foregroundColor)
        .frame(width: 106, height: 42)
        .background(backgroundColor, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color(.light60), lineWidth: 1)
        )
    }
}

#Preview {
    SelectedButtonView(action: {}, text: "Income",
                       foregroundColor: Color(.dark),
                       backgroundColor: .white)
}
