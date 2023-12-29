//
//  TransactionDetailsDescriptionView.swift
//
//
//  Created by Leonardo Mendez on 20/11/23.
//

import SwiftUI
import Shared

struct TransactionDetailsDescriptionView: View {
    
    @Binding var description: String
    @Binding var image: String
    @State private var isImageDetailViewPresented = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Image("discontinue-lines", bundle: .module)
                .frame(maxWidth: .infinity)
            Text("Description")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(Color(.light20))
            Text(description)
                .font(.system(size: 16))
                .foregroundColor(Color(.dark))
            if !image.isEmpty {
                Text("Attachment")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color(.light20))
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity)
                    .frame(height: 116)
                    .background(
                        Image(uiImage: UIImage.fromBase64(image) ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity)
                            .frame(height: 116)
                            .clipped()
                            .cornerRadius(8)
                            .onTapGesture {
                                isImageDetailViewPresented.toggle()
                            }
                            .sheet(isPresented: $isImageDetailViewPresented) {
                                ImageDetailView(image: image)
                            }
                    )
            }
            Spacer()
        }
    }
    
}

#Preview {
    TransactionDetailsDescriptionView(description: .constant(""), image: .constant(""))
}
