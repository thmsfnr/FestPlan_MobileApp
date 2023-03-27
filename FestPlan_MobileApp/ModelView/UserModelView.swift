//
//  UserModelView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import Combine
import Foundation

enum UserState {
    case ready
    case login(String,String)
    case signup(String,String,String,String)
    case error
}

class UserModelView : ObservableObject, Equatable, Hashable {
    
    @Published var idUser = 0
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var surname = ""
    @Published var role = 0
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

    init(idUser: Int? = nil, email: String? = nil, password: String? = nil, name: String? = nil, surname: String? = nil, role: Int? = nil) {
        if let idUser = idUser {
            self.idUser = idUser
        }
        if let email = email {
            self.email = email
        }
        if let password = password {
            self.password = password
        }
        if let name = name {
            self.name = name
        }
        if let surname = surname {
            self.surname = surname
        }
        if let role = role {
            self.role = role
        }
        self.state = .ready
    }
    
    static func == (lhs: UserModelView, rhs: UserModelView) -> Bool {
        return lhs.idUser == rhs.idUser
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.idUser)
    }
    
}
