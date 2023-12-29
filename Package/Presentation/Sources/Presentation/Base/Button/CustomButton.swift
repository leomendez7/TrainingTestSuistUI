//
//  CustomButton.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI
import Shared

struct CustomButton: View {
    
    var action: () -> Void
    @State var text: String
    @State var color: Color
    @State var foregroundColor: Color
    @State var height: CGFloat?
    @State var width: CGFloat?
    @State var cornerRadius: CGFloat?
    @State var fontSize: CGFloat?
    @State var fontWeight: Font.Weight?
    @State var bottom: CGFloat?
    
    var body: some View {
        Button(text) {
            action()
        }
        .font(.system(size: fontSize ?? 18))
        .fontWeight(fontWeight ?? .bold)
        .foregroundColor(foregroundColor)
        .frame(width: width ?? 353, height: height ?? 56)
        .background(color, in: RoundedRectangle(cornerRadius: cornerRadius ?? 16, style: .continuous))
        .padding(.bottom, bottom ?? 16)
    }
}

#Preview {
    CustomButton(action: {},
                 text: "Button",
                 color: Color(.violet100),
                 foregroundColor: .white, 
                 fontWeight: .semibold)
}
