//
//  SignInViewModel.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 02/03/2023.
//

import Combine
import Foundation

enum SignInState {
    case ready
    case login(String,String)
    case error
}

class SignInViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var isSignIn = false
    @Published var hasError = false
    
    @Published var state : SignInState = .ready {
        didSet {
            switch state {
                case .login(let newEmail, let newPassword):
                    self.email = newEmail
                    self.password = newPassword
                    self.isSignIn = true
                    self.state = .ready
                case .error:
                    self.state = .ready
                    self.hasError = true
                case .ready:
                    debugPrint("SignInViewModel: ready")
            }
        }
    }

    init() {
        self.state = .ready
    }
}
