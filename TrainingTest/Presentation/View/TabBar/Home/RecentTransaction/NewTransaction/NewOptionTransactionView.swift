//
//  NewTransactionView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import SwiftUI

struct NewOptionTransactionView: View {
    
    @State var isSheetPresented: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Text("Create transaction")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                    Spacer()
                    VStack(alignment: .leading) {
                        Button {
                            dismiss()
                        } label: {
                            Image("close")
                                .frame(width: 32, height: 32)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                VStack(spacing: 16) {
                    CustomButton(action: {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "income"),
                                                        object: nil)
                        dismiss()
                    }, text: "Income", color: .green100, foregroundColor: .white)
                    CustomButton(action: {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "expenses"),
                                                        object: nil)
                        dismiss()
                    }, text: "Expenses", color: .red100, foregroundColor: .white)
                }
            }
            .background(Color.white)
            .cornerRadius(16)
        }
}

#Preview {
    NewOptionTransactionView(isSheetPresented: true)
}
