//
//  TextModifier.swift
//
//
//  Created by Leonardo Mendez on 21/11/23.
//

import SwiftUI

struct TextModifier: ViewModifier {
    
    @State var size: CGFloat
    @State var color: Color
    @State var weight: Font.Weight
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size))
            .fontWeight(weight)
            .foregroundColor(color)
    }
    
}

extension Text {
    func textModifierStyle(size: CGFloat, color: Color, weight: Font.Weight) -> some View {
        self.modifier(TextModifier(size: size, color: color, weight: weight))
    }
}
