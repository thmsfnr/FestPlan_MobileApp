//
//  UserViewModel.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 21/03/2023.
//

import Combine
import Foundation

enum UserState {
    case ready
    case login(String,String)
    case signup(String,String,String,String)
    case error
}

class UserViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var surname = ""
    @Published var isCreated = false
    @Published var isSignIn = false
    @Published var hasError = false
    
    @Published var state : UserState = .ready {
        didSet {
            switch state {
                case .login(let newEmail, let newPassword):
                    self.email = newEmail
                    self.password = newPassword
                    self.isSignIn = true
                    self.state = .ready
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
                    debugPrint("UserViewModel: ready")
            }
        }
    }

    init() {
        self.state = .ready
    }
    
}
