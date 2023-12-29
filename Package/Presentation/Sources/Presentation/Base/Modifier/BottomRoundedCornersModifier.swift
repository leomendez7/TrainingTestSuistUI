//
//  BottomRoundedCornersModifier.swift
//
//
//  Created by Leonardo Mendez on 20/11/23.
//

import SwiftUI

struct BottomRoundedCornersModifier: ViewModifier {
    
    var cornerRadius: CGFloat
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .background(
                    Path { path in
                        let width = geometry.size.width
                        let height = geometry.size.height
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: 0, y: height - cornerRadius))
                        path.addQuadCurve(to: CGPoint(x: cornerRadius, y: height), control: CGPoint(x: 0, y: height))
                        path.addLine(to: CGPoint(x: width - cornerRadius, y: height))
                        path.addQuadCurve(to: CGPoint(x: width, y: height - cornerRadius), control: CGPoint(x: width, y: height))
                        path.addLine(to: CGPoint(x: width, y: 0))
                        path.closeSubpath()
                    }
                    .fill(backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 0, style: .continuous))
                )
        }
    }
}

extension View {
    
    func bottomRoundedCorners(cornerRadius: CGFloat, backgroundColor: Color) -> some View {
        self.modifier(BottomRoundedCornersModifier(cornerRadius: cornerRadius, backgroundColor: backgroundColor))
    }
    
}
