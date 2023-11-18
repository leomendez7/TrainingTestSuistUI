//
//  SwiftUIView.swift
//  
//
//  Created by Leonardo Mendez on 17/11/23.
//

import SwiftUI
import Domain

struct TransactionDetailsView: View {
    
    @State private var isSheetPresented = false
    @State var isRemove: Bool = false
//    @Binding var isIncome: Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: Store
    @StateObject var viewModel: TransactionDetailsViewModel
    
    var body: some View {
        VStack {
//            if isIncome {
                Color(.green100)
                    .ignoresSafeArea()
//            } else {
//                Color(.red100)
//                    .ignoresSafeArea()
//            }
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .transactionDetailsToolbar(isSheetPresented: $isSheetPresented, isRemove: isRemove)
        .navigationBarItems(leading: BackNavigationButton(action: {
            store.transactions.removeLast()
        }, image: "arrow-left", color: Color(.light80)))
        .onChange(of: isRemove) { _ in
            
        }
    }
    
    func configureView() {
        
    }
    
}

#Preview {
    TransactionDetailsView(viewModel: Constants.transactionDetailsViewModel)
        .environmentObject(Store())
}
