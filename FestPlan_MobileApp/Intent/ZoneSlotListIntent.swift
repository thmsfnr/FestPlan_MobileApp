//
//  ZoneSlotListIntent.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 25/03/2023.
//

import Foundation
import SwiftUI

struct ZoneSlotListIntent {
    
    @ObservedObject private var model : ZoneSlotListModelView
    init(zoneSlotList: ZoneSlotListModelView){
        self.model = zoneSlotList
    }
    
    func loadFestival(festival: Int){
        let idUser: Int
        if let userData = UserDefaults.standard.data(forKey: "user") {
            do {
                let user = try JSONDecoder().decode(Auth.self, from: userData)
                idUser = user.id
                UserSlotService().getUserSlot(UserIdUser: idUser) { result3 in
                    DispatchQueue.main.async {
                        ZoneService().getZone(festival: festival) { result in
                            DispatchQueue.main.async {
                                for zone in result {
                                    SlotService().getSlot(zone: zone.idZone) { result2 in
                                        var list2: [SlotModelView] = []
                                        for slot in result2 {
                                            var exist = true
                                            for elem in result3 {
                                                if elem.SlotIdSlot == slot.idSlot {
                                                    exist = false
                                                    break
                                                }
                                            }
                                            if exist {
                                                list2.append(SlotModelView(idSlot: slot.idSlot, startHour: slot.startHour, endHour: slot.endHour, day: slot.day, zone: slot.zone, nameDay: slot.Day?.nameDay))
                                            }
                                        }
                                        if list2.count != 0 {
                                            DispatchQueue.main.async {
                                                self.model.state = .addUserSlot(ZoneSlotModelView(idZone: zone.idZone, nameZone: zone.nameZone, maxVolunteers: zone.maxVolunteers, festival: zone.festival, slots: list2))
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            self.model.state = .ready
                        }
                    }
                }
            } catch {
                print("Error decoding user data: \(error)")
            }
        } else {
            print("No user data found in UserDefaults")
        }
    }
    
    func signup(slot: Int, zone: Int){
        let idUser: Int
        if let userData = UserDefaults.standard.data(forKey: "user") {
            do {
                let user = try JSONDecoder().decode(Auth.self, from: userData)
                idUser = user.id
                UserSlotService().createUserSlot(SlotIdSlot: slot, UserIdUser: idUser, zone: zone) { success, error in
                    if !success {
                        return
                    }
                    DispatchQueue.main.async {
                        self.model.state = .signup(slot, zone)
                    }
                }
            } catch {
                print("Error decoding user data: \(error)")
            }
        } else {
            print("No user data found in UserDefaults")
        }
    }
    
}
