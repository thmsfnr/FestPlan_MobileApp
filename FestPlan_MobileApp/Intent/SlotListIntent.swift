//
//  SlotListIntent.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 29/03/2023.
//

import Foundation
import SwiftUI

struct SlotListIntent {
    
    @ObservedObject private var model : SlotListModelView
    
    init(slotList: SlotListModelView){
        self.model = slotList
    }
    
    func load(festival: Int){
        DayService().getDay(festival: festival) { result in
            DispatchQueue.main.async {
                for elem in result {
                    SlotService().getSlot(day: elem.idDay) { result2 in
                        DispatchQueue.main.async {
                            for elem2 in result2 {
                                self.model.state = .load(elem2)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.model.state = .ready
                    }
                }
            }
        }
    }
    
    func remove(slot: Int) {
        SlotService().deleteSlot(idSlot: slot) { success, error in
            if !success {
                return
            }
        }
    }
    
    func create(startHour: String, endHour: String, day: Int, zone: Int) {
        SlotService().createSlot(startHour: startHour, endHour: endHour, day: day, zone: zone) { success, error in
            if !success {
                return
            }
            DispatchQueue.main.async {
                self.model.state = .ready
            }
        }
    }
    
}
