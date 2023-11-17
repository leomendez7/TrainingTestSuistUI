//
//  NewTransactionViewModel.swift
//  TrainingTest
//
//  Created by Leonardo Mendez on 6/11/23.
//

import Foundation
import Combine
import SwiftUI
import Domain

public class NewTransactionViewModel: BaseViewModel<CreateTransactionUseCase>, ObservableObject {
 
    var transaction = Trade()
    @Published var success: Bool = false
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
    private var store: Store
    private var cancellables: Set<AnyCancellable> = []
    
    public init(useCase: CreateTransactionUseCase, store: Store) {
        self.store = store
        super.init(useCase: useCase)
        self.subscribe()
    }
    
    func showPhotoPicker() {
        if source == .camera {
            if !Picker.checkPermissions() {
                print("There is no camera on this device")
                return
            }
        }
        showPicker = true
    }
    
    func createTransaction(trade: Trade) async {
        do {
            let response = try await useCase.execute(requestValue: trade)
            DispatchQueue.main.async {
                self.success = response
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func fetchTrade() async {
        do {
            let response = try await useCase.fetchTrades(email: Default.user()?.email ?? "")
            print(response)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func subscribe() {
        $success.sink { response in
            if response {
                self.store.transactions.removeLast()
            }
        }.store(in: &cancellables)
    }
    
}
