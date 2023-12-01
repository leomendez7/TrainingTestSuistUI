//
//  PinView.swift
//
//
//  Created by Leonardo Mendez on 1/12/23.
//

import SwiftUI

struct PinView: View {
    @State private var enteredPIN: String = ""
    
    var body: some View {
        VStack {
            Text("Let’s setup your PIN")
                .textModifierStyle(size: 18, color: .white, weight: .bold)
                .padding()
            Spacer()
            HStack(spacing: 10) {
                ForEach(0..<4) { index in
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundColor(index < enteredPIN.count ? .white : .clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 32)
                            .inset(by: 2)
                            .stroke(index < enteredPIN.count ? .clear : Color(.border10))
                        )
                }
            }
            Spacer()
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                ForEach(1..<10) { number in
                    PINButton(number: "\(number)", action: {
                        self.enteredPIN.append("\(number)")
                        checkPIN()
                    })
                }
            }
            
            HStack {
                Spacer()
                PINButton(number: "0", action: {
                    self.enteredPIN.append("0")
                    checkPIN()
                })
                Spacer()
                PINButton(number: ">", action: {
                    // Acción al presionar el botón de aceptar
                    // Puedes realizar la lógica que desees aquí
                    print("Aceptar presionado")
                })
                Spacer()
            }

        }
        .background(Color(.violet100))
        
    }
    
    private func checkPIN() {
        if enteredPIN.count == 4 {
            print("PIN ingresado: \(enteredPIN)")
//            enteredPIN = ""
        }
    }
}

#Preview {
    PinView()
}

struct PINButton: View {
    var number: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(number)
                .textModifierStyle(size: 48, color: .white, weight: .semibold)
        }
    }
}
