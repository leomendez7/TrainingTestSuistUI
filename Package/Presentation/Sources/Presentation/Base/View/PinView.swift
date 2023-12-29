//
//  PinView.swift
//
//
//  Created by Leonardo Mendez on 1/12/23.
//

import SwiftUI
import Domain

public struct PinView: View {
    
    var isInitial: Bool
    @State private var text = "Let’s setup your PIN"
    @State private var enteredPIN: String = ""
    @State private var confirmationPIN: String = ""
    @State private var confirmationPINSuccess = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Binding var cancelPin: Bool
    @Environment(\.dismiss) var dismiss
    
    public init(isInitial: Bool, cancelPin: Binding<Bool>) {
        self.isInitial = isInitial
        self._cancelPin = cancelPin
    }
    
    public var body: some View {
        Group {
            if confirmationPINSuccess {
                TabBarView()
            } else {
                VStack {
                    Text(text)
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
                            PINButton(image: "", number: "\(number)", action: {
                                self.enteredPIN.append("\(number)")
                                checkPIN()
                            })
                        }
                        if isInitial {
                            Spacer()
                        } else {
                            
                            PINButton(height: 38, width: 38, image: "close", number: "", action: {
                                dismiss()
                                cancelPin = true
                            })
                        }
                        PINButton(image: "", number: "0", action: {
                            self.enteredPIN.append("0")
                            checkPIN()
                        })
                        PINButton(image: "pin-arrow-right", number: "", action: {
                            alertMessage = "The codes are not incorrect. Try again."
                            comparePIN()
                        })
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Error!"), message: Text(alertMessage), dismissButton: .default(Text("Try Again")))
                        }
                    }
                }
                .background(Color(.violet100))
            }
        }
    }
    
    private func checkPIN() {
        if let security = Default.security  {
            if security.pin.isEmpty {
                if enteredPIN.count == 4 && confirmationPIN.count == 0 {
                    confirmationPIN = enteredPIN
                    enteredPIN = ""
                    text = "Ok. Re type your PIN again."
                }
            } else {
                if enteredPIN.count == 4 {
                    confirmationPIN = security.pin
                    alertMessage = "The code is not incorrect. Try again."
                    comparePIN()
                }
            }
        }
    }
    
    private func comparePIN() {
        if enteredPIN == confirmationPIN {
            var security = Security()
            security.name = .pin
            security.pin = enteredPIN
            Default.save(security: security)
            if isInitial {
                confirmationPINSuccess = true
            } else {
                dismiss()
            }
        } else{
            showAlert = true
            enteredPIN = ""
            confirmationPIN = ""
        }
    }
    
}

#Preview {
    PinView(isInitial: false, cancelPin: .constant(false))
}

struct PINButton: View {
    
    @State var height: CGFloat?
    @State var width: CGFloat?
    var image: String
    var number: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            if image.isEmpty {
                Text(number)
                    .textModifierStyle(size: 48, color: .white, weight: .semibold)
            } else {
                Image(image, bundle: .module)
                    .resizable()
                    .frame(width: width ?? 64, height: height ?? 64)
                    .foregroundColor(.white)
            }
        }
    }
    
}
