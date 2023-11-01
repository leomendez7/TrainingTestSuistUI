//
//  CustomDateTextField.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 31/10/23.
//

import SwiftUI

struct CustomDateTextField: View {
    
    @State private var isDatePickerVisible = false
    @State private var selectedDate = Date()
    @State var text: String = ""
    
    var placeholder: String

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.light20)
                    .padding(.horizontal, 16)
            }
            TextField(text, text: .constant(""))
                .foregroundColor(.black)
                .padding(.horizontal, 16)
                .onTapGesture {
                    isDatePickerVisible.toggle()
                }
        }
        .frame(height: 56)
        .background(.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.light60, lineWidth: 1)
        )
        .sheet(isPresented: $isDatePickerVisible) {
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
        }
        .onChange(of: selectedDate) { newValue in
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            text = formatter.string(from: newValue)
        }
    }
}

#Preview {
    CustomDateTextField(placeholder: "")
}
