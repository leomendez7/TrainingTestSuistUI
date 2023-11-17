//
//  SwiftUIView.swift
//  
//
//  Created by Leonardo Mendez on 17/11/23.
//

import SwiftUI
import Domain

struct TransactionDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: TransactionDetailsViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    func configureView() {
        
    }
    
}

#Preview {
    TransactionDetailsView(viewModel: Constants.transactionDetailsViewModel)
}
