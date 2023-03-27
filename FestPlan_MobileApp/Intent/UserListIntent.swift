//
//  UserListIntent.swift
//  FestPlan_MobileApp
//
//  Created by etud on 27/03/2023.
//

import Foundation
import SwiftUI

struct UserListIntent {
    
    @ObservedObject private var model : UserListModelView
    
    init(userList: UserListModelView){
        self.model = userList
    }
    
    func load(){
        UserService().getUser() { result in
            DispatchQueue.main.async {
                self.model.state = .load(result)
            }
        }
        DispatchQueue.main.async {
            self.model.state = .ready
        }
    }
}
