//
//  ValueTextFieldView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 3/11/23.
//

import SwiftUI

struct ValueTransactionTextFieldView: View {
    
    @State var text: String = "0"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("How much?")
                .padding(.horizontal, 16)
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundColor(Color("light-80", bundle: .module))
                .opacity(0.64)
            HStack {
                Text("$")
                    .foregroundColor(Color("light-80", bundle: .module))
                    .font(.system(size: 64))
                    .fontWeight(.bold)
                    .padding(.leading, 16)
                TextField("0", text: $text)
                    .foregroundColor(Color("light-80", bundle: .module))
                    .font(.system(size: 64))
                    .fontWeight(.bold)
                    .padding(.trailing, 16)
                    .keyboardType(.numberPad)
            }
        }
    }
}

#Preview {
    ValueTransactionTextFieldView()
}