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
        HStack() {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(.light20))
            } else {
                Text(text)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(.dark))
                
            }
            Spacer()
        }
        .onTapGesture {
            isDatePickerVisible.toggle()
        }
        .frame(height: 56)
        .background(.white)
        .cornerRadius(16)
        .padding(.horizontal, 16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.light60), lineWidth: 1)
        )
        .sheet(isPresented: $isDatePickerVisible) {
            let today = Calendar.current.startOfDay(for: Date())
            DatePicker(  "", selection: $selectedDate, in: ...today, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                .presentationDetents([.fraction(0.50)])
        }
        
        .onChange(of: selectedDate) { newValue in
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            text = formatter.string(from: newValue)
        }
    }
}

#Preview {
    CustomDateTextField(placeholder: "test")
}
