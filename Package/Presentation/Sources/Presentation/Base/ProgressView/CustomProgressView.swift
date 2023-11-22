//
//  ProgressView.swift
//
//
//  Created by Leonardo Mendez on 21/11/23.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                CustomProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color(.violet100)))
                    .padding(20)
                Spacer()
            }
        }
    }
}

#Preview {
    CustomProgressView()
}
