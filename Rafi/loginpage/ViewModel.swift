//
//  ViewModel.swift
//  Rafi
//
//  Created by Noor Alhassani on 12/06/1447 AH.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isLoggedIn: Bool = false
    
    private let authService = AuthService()
    
    func login() {
        Task {
            isLoading = true
            errorMessage = nil
            
            do {
                _ = try await authService.login(username: username, password: password)
                isLoggedIn = true
            } catch {
                errorMessage = error.localizedDescription
            }
            
            isLoading = false
        }
    }
}
