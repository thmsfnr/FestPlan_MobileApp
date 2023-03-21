//
//  SignUpIntent.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 20/03/2023.
//

import SwiftUI

struct SignUpIntent {
    
    @ObservedObject private var model : SignUpViewModel
    init(signUp: SignUpViewModel){
        self.model = signUp
    }
    
    func signup(email: String, password: String, name: String, surname: String){
        if (email.count < 4 && password.count < 4) {
           self.model.state = .error
        } else {
            AuthService().signup(email: email, password: password, name: name, surname: surname) { success, error in
                if !success {
                    DispatchQueue.main.async {
                        self.model.state = .error
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.model.state = .signup(email,password,name,surname)
                }
            }
        }
        DispatchQueue.main.async {
            self.model.state = .ready
        }
    }
}
