//
//  SlotModelView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import Combine
import Foundation

class SlotModelView : ObservableObject, Equatable, Hashable {
    
    @Published var idSlot = 0
    @Published var startHour = ""
    @Published var endHour = ""
    @Published var day = 0
    @Published var zone = 0
    @Published var nameDay = ""
    
    init(idSlot: Int? = nil, startHour: String? = nil, endHour: String? = nil, day: Int? = nil, zone: Int? = nil, nameDay: String? = nil) {
        if let idSlot = idSlot {
            self.idSlot = idSlot
        }
        if let startHour = startHour {
            self.startHour = startHour
        }
        if let endHour = endHour {
            self.endHour = endHour
        }
        if let day = day {
            self.day = day
        }
        if let zone = zone {
            self.zone = zone
        }
        if let nameDay = nameDay {
            self.nameDay = nameDay
        }
    }
    
    static func == (lhs: SlotModelView, rhs: SlotModelView) -> Bool {
        return lhs.idSlot == rhs.idSlot
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.idSlot)
    }
    
}
