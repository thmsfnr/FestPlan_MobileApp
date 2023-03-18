//
//  SignInIntent.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 18/03/2023.
//

import SwiftUI

struct SignInIntent {
    
    @ObservedObject private var model : SignInViewModel
    init(signIn: SignInViewModel){
        self.model = signIn
    }
    
    func login(email: String, password: String){
        if (email.count < 4 && password.count < 4) {
           self.model.state = .error
        } else {
            AuthService().login(email: email, password: password) { success, error in
                if !success {
                    self.model.state = .error
                    return
                }
            }
            self.model.state = .login(email,password)
        }
        self.model.state = .ready
    }
}
