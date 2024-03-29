//
//  UserSlotModelView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import Combine
import Foundation

enum UserSlotState {
    case ready
    case loadUser(UserSlot)
    case loadZone(UserSlot)
    case error
}

class UserSlotModelView : ObservableObject, Equatable, Hashable {
    
    var id: UUID
    @Published var UserIdUser = 0
    @Published var SlotIdSlot = 0
    @Published var zone = 0
    @Published var hasError = false
    @Published var nameZone = ""
    @Published var nameDay = ""
    @Published var startHour = ""
    @Published var endHour = ""
    @Published var maxVolunteers = 0
    
    
    @Published var state : UserSlotState = .ready {
        didSet {
            switch state {
                case .loadUser(let newUserSlot):
                    self.UserIdUser = newUserSlot.UserIdUser
                    self.SlotIdSlot = newUserSlot.SlotIdSlot
                    self.zone = newUserSlot.zone
                    self.state = .ready
                case .loadZone(let newUserSlot):
                    self.UserIdUser = newUserSlot.UserIdUser
                    self.SlotIdSlot = newUserSlot.SlotIdSlot
                    self.zone = newUserSlot.zone
                    self.maxVolunteers = newUserSlot.Zone!.maxVolunteers
                    self.state = .ready
                case .error:
                    self.state = .ready
                    self.hasError = true
                case .ready:
                    debugPrint("UserSlotViewModel: ready")
            }
        }
    }

    init(UserIdUser: Int? = nil, SlotIdSlot: Int? = nil, zone: Int? = nil, nameZone: String? = nil, nameDay: String? = nil, startHour: String? = nil, endHour: String? = nil, maxVolunteers: Int? = nil) {
        self.id = UUID()
        if let UserIdUser = UserIdUser {
            self.UserIdUser = UserIdUser
        }
        if let SlotIdSlot = SlotIdSlot {
            self.SlotIdSlot = SlotIdSlot
        }
        if let zone = zone {
            self.zone = zone
        }
        if let nameZone = nameZone {
            self.nameZone = nameZone
        }
        if let nameDay = nameDay {
            self.nameDay = nameDay
        }
        if let startHour = startHour {
            self.startHour = startHour
        }
        if let endHour = endHour {
            self.endHour = endHour
        }
        if let maxVolunteers = maxVolunteers {
            self.maxVolunteers = maxVolunteers
        }
        self.state = .ready
    }
    
    static func == (lhs: UserSlotModelView, rhs: UserSlotModelView) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
}
