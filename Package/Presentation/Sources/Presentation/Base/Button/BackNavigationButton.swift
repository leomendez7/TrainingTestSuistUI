//
//  SwiftUIView.swift
//  
//
//  Created by Leonardo Mendez on 18/11/23.
//

import SwiftUI

struct BackNavigationButton: View {
    
    var action: () -> Void
    @State var image: String
    @State var color: Color
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Image(image, bundle: .module)
                    .foregroundColor(color)
            }
        }
    }
}

#Preview {
    BackNavigationButton(action: {}, image: "arrow-left", color: Color(.light80))
}
