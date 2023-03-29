//
//  UserSlotListIntent.swift
//  FestPlan_MobileApp
//
//  Created by etud on 24/03/2023.
//

import Foundation
import SwiftUI

struct UserSlotListIntent {
    
    @ObservedObject private var model : UserSlotListModelView
    init(userSlotList: UserSlotListModelView){
        self.model = userSlotList
    }
    
    func loadUser(){
        let idUser: Int
        if let userData = UserDefaults.standard.data(forKey: "user") {
            do {
                let user = try JSONDecoder().decode(Auth.self, from: userData)
                idUser = user.id
                UserSlotService().getUserSlot(UserIdUser: idUser) { result in
                    DispatchQueue.main.async {
                        for userSlot in result {
                            DayService().getDay(idDay: userSlot.Slot?.day) { day in
                                DispatchQueue.main.async {
                                    self.model.state = .loadUser(userSlot,day[0].nameDay)
                                }
                            }
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.model.state = .ready
                }
            } catch {
                print("Error decoding user data: \(error)")
            }
        } else {
            print("No user data found in UserDefaults")
        }
    }
    
    func remove(uId: Int, sId: Int) {
        UserSlotService().deleteUserSlot(SlotIdSlot: sId, UserIdUser: uId) { success, error in
            if !success {
                return
            }
        }
    }
    
}
