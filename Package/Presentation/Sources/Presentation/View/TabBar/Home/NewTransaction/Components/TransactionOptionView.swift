//
//  TransactionOptionView.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 2/11/23.
//

import SwiftUI
import Domain
import Shared
import Combine

struct TransactionOptionView: View {
    
    @State private var isSwitchOn = false
    @State var isIncome: Bool
    @State var description = String()
    @State var selectedCategory = "Shopping"
    @State var selectedPayment = "Wallet"
    @State private var showAlert = false
    @State private var titleAlert: String = ""
    @State private var textAlert: String = ""
    @State var balance: String
    @Binding var value: String
    @StateObject var viewModel: NewTransactionViewModel
    
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
                if (!isIncome && ((Int(value) ?? 0) >= Int(balance) ?? 0)) {
                    titleAlert = "Alert!"
                    textAlert = "The value cannot be greater than the balance."
                    showAlert.toggle()
                } else if self.value != "0" && !self.value.isEmpty {
                    createTransaction()
                } else {
                    titleAlert = "Alert!"
                    textAlert = "The value should not be 0."
                    showAlert.toggle()
                }
            }, text: "Continue", color: Color(.violet100), foregroundColor: .white)
            Spacer()
                .sheet(isPresented: $viewModel.showPicker, content: {
                    ImagePicker(sourceType: viewModel.source == .library 
                                ? .photoLibrary : .camera, selectedImage: $viewModel.image)
                        .ignoresSafeArea()
                })
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(titleAlert),
                message: Text(textAlert),
                dismissButton: .default(Text("OK"))
            )
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
        .topRoundedCorners(cornerRadius: 32, backgroundColor: .white)
    }
    
    func createTransaction() {
        viewModel.transaction.email = Default.user()?.email ?? ""
        viewModel.transaction.category = selectedCategory
        viewModel.transaction.description = description
        viewModel.transaction.payment = selectedPayment
        viewModel.transaction.value = value
        viewModel.transaction.isIncome = isIncome
        Task {
            await viewModel.createTransaction(trade: viewModel.transaction)
        }
    }
}

#Preview {
    TransactionOptionView(isIncome: true, balance: "", value: .constant("0"), viewModel: Constants.newTransactionViewModel)
}
