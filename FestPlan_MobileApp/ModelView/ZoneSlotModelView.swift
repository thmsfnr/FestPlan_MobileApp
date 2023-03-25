//
//  ZoneSlotModelView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 25/03/2023.
//

import Combine
import Foundation

class ZoneSlotModelView : ObservableObject, Equatable, Hashable {
    
    @Published var idZone = 0
    @Published var nameZone = ""
    @Published var maxVolunteers = 0
    @Published var festival = 0
    @Published var slots: [SlotModelView] = []

    init(idZone: Int? = nil, nameZone: String? = nil, maxVolunteers: Int? = nil, festival: Int? = nil, slots: [SlotModelView]? = nil) {
        if let idZone = idZone {
            self.idZone = idZone
        }
        if let nameZone = nameZone {
            self.nameZone = nameZone
        }
        if let maxVolunteers = maxVolunteers {
            self.maxVolunteers = maxVolunteers
        }
        if let festival = festival{
            self.festival = festival
        }
        if let slots = slots{
            self.slots = slots
        }
    }
    
    static func == (lhs: ZoneSlotModelView, rhs: ZoneSlotModelView) -> Bool {
        return lhs.idZone == rhs.idZone
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.idZone)
    }
    
}
