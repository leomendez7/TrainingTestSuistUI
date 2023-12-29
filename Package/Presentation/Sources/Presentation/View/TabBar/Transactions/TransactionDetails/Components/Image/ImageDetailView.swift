//
//  ImageDetailView.swift
//
//
//  Created by Leonardo Mendez on 30/11/23.
//

import SwiftUI
import Shared

struct ImageDetailView: View {
    
    var image: String
    
    var body: some View {
        VStack {
            Image(uiImage: UIImage.fromBase64(image) ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
            .padding()
        }
        .padding()
    }
}

#Preview {
    ImageDetailView(image: "")
}
