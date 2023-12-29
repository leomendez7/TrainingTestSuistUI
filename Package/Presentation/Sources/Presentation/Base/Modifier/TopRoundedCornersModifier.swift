//
//  TopRoundedCornersModifier.swift
//
//
//  Created by Leonardo Mendez on 15/11/23.
//

import SwiftUI

struct TopRoundedCornersModifier: ViewModifier {
    
    var cornerRadius: CGFloat
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .background(
                    Path { path in
                        let width = geometry.size.width
                        let height = geometry.size.height
                        path.move(to: CGPoint(x: 0, y: height))
                        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
                        path.addQuadCurve(to: CGPoint(x: cornerRadius, y: 0), control: CGPoint.zero)
                        path.addLine(to: CGPoint(x: width - cornerRadius, y: 0))
                        path.addQuadCurve(to: CGPoint(x: width, y: cornerRadius), control: CGPoint(x: width, y: 0))
                        path.addLine(to: CGPoint(x: width, y: height))
                        path.closeSubpath()
                    }
                        .fill(backgroundColor)
                        .clipShape(RoundedRectangle(cornerRadius: 0, style: .continuous))
                )
        }
    }
}

extension View {
    
    func topRoundedCorners(cornerRadius: CGFloat, backgroundColor: Color) -> some View {
        self.modifier(TopRoundedCornersModifier(cornerRadius: cornerRadius, backgroundColor: backgroundColor))
    }
    
}
