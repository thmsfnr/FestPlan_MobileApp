//
//  UserListIntent.swift
//  FestPlan_MobileApp
//
//  Created by Loris Bouchez on 27/03/2023.
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
    
    func loadSlot(slot: Int){
        UserSlotService().getUserSlot(SlotIdSlot: slot) { result in
            DispatchQueue.main.async {
                var list: [User] = []
                for elem in result {
                    list.append(elem.User!)
                }
                self.model.state = .loadSlot(list)
            }
        }
        DispatchQueue.main.async {
            self.model.state = .ready
        }
    }
    
    func loadFree(slot: Int) {
        UserService().getUser() { result in
            DispatchQueue.main.async {
                UserSlotService().getUserSlot(SlotIdSlot: slot) { result2 in
                        DispatchQueue.main.async {
                            if result2.count == 0 {
                                self.model.state = .loadFree(result)
                            }
                            else {
                                var list: [User] = []
                                for elem in result {
                                    var ok = true
                                    for elem2 in result2 {
                                        if elem2.User?.idUser == elem.idUser {
                                            ok = false
                                        }
                                    }
                                    if ok {
                                        list.append(elem)
                                    }
                                }
                                self.model.state = .loadFree(list)
                            }
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                self.model.state = .ready
            }
        }
    
    func remove(user: Int, slot: Int) {
        UserSlotService().deleteUserSlot(SlotIdSlot: slot, UserIdUser: user) { success, error in
            if !success {
                return
            }
        }
        DispatchQueue.main.async {
            self.model.state = .ready
        }
    }
    
    func add(user: Int, slot: Int, zone: Int) {
        UserSlotService().createUserSlot(SlotIdSlot: slot, UserIdUser: user, zone: zone) { success, error in
            if !success {
                return
            }
        }
        DispatchQueue.main.async {
            self.model.state = .ready
        }
    }
    
}
