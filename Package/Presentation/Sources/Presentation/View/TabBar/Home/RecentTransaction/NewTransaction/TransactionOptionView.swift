//
//  TransactionOptionView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import SwiftUI

struct TransactionOptionView: View {
    
    @State private var isSwitchOn = false
    @State var description = String()
    @State var selectedCategory = "Category"
    @State var selectedPayment = "Wallet"
    @Binding var value: String
    @EnvironmentObject var viewModel: NewTransactionViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            CategorySelectorView(selectedCategory: $selectedCategory)
            CustomTextField(text: $description, placeholder: "Description")
            PayMethodSelectorView(selectedPayment: $selectedPayment)
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 112, height: 112)
            } else {
                Button(action:{
                    viewModel.source = .camera
                    viewModel.showPhotoPicker()
                }) {
                    Image("add-attachment", bundle: .module)
                }
            }
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Reminder")
                        .multilineTextAlignment(TextAlignment.leading)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.dark25))
                    Text("Set a transaction reminder")
                        .font(.system(size: 13))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.light20))
                }
                Spacer()
                Toggle("", isOn: $isSwitchOn)
                    .toggleStyle(SwitchToggleStyle(tint: Color(.violet100)))
            }
            Spacer()
            CustomButton(action: {
                
            }, text: "Continue", color: Color(.violet100), foregroundColor: .white)
            Spacer()
                .sheet(isPresented: $viewModel.showPicker, content: {
                    ImagePicker(sourceType: viewModel.source == .library 
                                ? .photoLibrary : .camera, selectedImage: $viewModel.image)
                        .ignoresSafeArea()
                })
        }
        .frame(height: UIScreen.main.bounds.size.height * 0.60)
        .padding(.horizontal, 16)
        .padding(.top, 24)
        .background(.white, in: RoundedRectangle(cornerRadius: 32, style: .continuous))
    }
    
    func createTransaction() {
        
    }
}

#Preview {
    TransactionOptionView(value: .constant("0"))
}
