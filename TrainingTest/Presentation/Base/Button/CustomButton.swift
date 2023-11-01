//
//  CustomButton.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

struct CustomButton: View {
    
    var action: () -> Void
    @State var text: String
    @State var color: Color
    @State var foregroundColor: Color
    
    var body: some View {
        Button(text) {
            action()
        }
        .font(.system(size: 18))
        .fontWeight(.bold)
        .foregroundColor(foregroundColor)
        .frame(width: 353, height: 56)
        .background(color, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    CustomButton(action: {},
                 text: "",
                 color: .violet100,
                 foregroundColor: .white)
}
