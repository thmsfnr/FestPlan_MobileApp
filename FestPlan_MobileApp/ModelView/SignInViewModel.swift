//
//  SignInViewModel.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 02/03/2023.
//

import Combine
import Foundation

enum TrackState {
    case ready
    case login(String,String)
    case error
}

class SignInViewModel : ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var name = ""
    @Published var surname = ""
    @Published var isSignIn = false
    @Published var haserror = false
    
    // -----------------------------------------------------------
    // State Intent management
    @Published var state : TrackState = .ready {
        didSet {
            switch state {
            case .login(let newEmail, let newPassword):
                // si le nom convient :
                self.email = newEmail
                self.password = newPassword
                self.state = .ready
                // sinon on fait passer le state en .error
            case .error:
                debugPrint("error")
                self.state = .ready
            case .ready:
                debugPrint("TrackViewModel: ready state")
                debugPrint("--------------------------------------")
            default:
                break
            }
        }
    }
    
    var canSignIn: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    init() {
        self.state = .ready
    }
    
    func login(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
}
