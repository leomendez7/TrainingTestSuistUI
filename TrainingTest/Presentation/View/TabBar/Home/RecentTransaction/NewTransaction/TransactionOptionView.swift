//
//  TransactionOptionView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import SwiftUI

struct TransactionOptionView: View {
    
    @State private var isSwitchOn = false
    
    var body: some View {
        VStack(spacing: 16) {
            CategorySelectorView()
            CustomTextField(text: "", placeholder: "Description")
            PayMethodSelectorView()
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Reminder")
                        .multilineTextAlignment(TextAlignment.leading)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.dark25)
                    Text("Set a transaction reminder")
                        .font(.system(size: 13))
                        .fontWeight(.semibold)
                        .foregroundColor(.light20)
                }
                Spacer()
                Toggle("", isOn: $isSwitchOn)
                    .toggleStyle(SwitchToggleStyle(tint: .violet100))
            }
            Spacer()
            CustomButton(action: {
                
            }, text: "Continue", color: .violet100, foregroundColor: .white)
            Spacer()
        }
        .frame(height: UIScreen.main.bounds.size.height * 0.50)
        .padding(.horizontal, 16)
        .padding(.top, 24)
        .background(.white, in: RoundedRectangle(cornerRadius: 32, style: .continuous))
    }
}

#Preview {
    TransactionOptionView()
}
