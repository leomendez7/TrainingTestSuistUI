//
//  CircularImageView.swift
//
//
//  Created by Leonardo Mendez on 23/11/23.
//

import SwiftUI

struct CircularImageView: View {
    
    var image: UIImage
    @State var height: CGFloat?
    @State var width: CGFloat?
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width ?? 80, height: height ?? 80)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 4)
                    .padding(2)
            )
            .overlay(
                Circle()
                    .stroke(Color.purple, lineWidth: 2)
            )
    }
}

#Preview {
    CircularImageView(image: UIImage())
}
