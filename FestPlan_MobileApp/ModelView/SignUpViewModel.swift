//
//  SignUpViewModel.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 20/03/2023.
//

import Combine
import Foundation

enum SignUpState {
    case ready
    case signup(String,String,String,String)
    case error
}

class SignUpViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var surname = ""
    @Published var isCreated = false
    @Published var hasError = false
    
    @Published var state : SignUpState = .ready {
        didSet {
            switch state {
                case .signup(let newEmail, let newPassword, let newName, let newSurname):
                    self.email = newEmail
                    self.password = newPassword
                    self.name = newName
                    self.surname = newSurname
                    self.isCreated = true
                    self.state = .ready
                case .error:
                    self.state = .ready
                    self.hasError = true
                case .ready:
                    debugPrint("SignUpViewModel: ready")
            }
        }
    }

    init() {
        self.state = .ready
    }
}
