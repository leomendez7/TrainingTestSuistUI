//
//  CustomImageView.swift
//
//
//  Created by Leonardo Mendez on 21/11/23.
//

import SwiftUI

struct CustomImageView: View {
    
    var action: () -> Void
    @State var image: UIImage
    
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 112, height: 112)
            .background(
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 112, height: 112)
                    .clipped()
                    .cornerRadius(8)
            )
        Button(action: {
//            viewModel.image = nil
            action()
        }) {
            Image("close-2", bundle: .module)
                .foregroundColor(.red)
                .background(Color.white)
                .clipShape(Circle())
        }
        .padding(8)
        .offset(x: 50, y: -50)
    }
}

#Preview {
    CustomImageView(action: {}, image: UIImage())
}
