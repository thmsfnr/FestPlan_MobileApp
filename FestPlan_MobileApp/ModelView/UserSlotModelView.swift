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
    case loadOpen(UserSlot)
    case error
}

class UserSlotModelView : ObservableObject {
    
    @Published var UserIdUser = 0
    @Published var SlotIdSlot = 0
    @Published var zone = 0
    @Published var isOpen = false
    @Published var hasError = false
    
    @Published var state : UserSlotState = .ready {
        didSet {
            switch state {
                case .loadOpen(let newUserSlot):
                    self.UserIdUser = newUserSlot.UserIdUser
                    self.SlotIdSlot = newUserSlot.SlotIdSlot
                    self.zone = newUserSlot.zone
                    self.isOpen = newUserSlot.isOpen
                    self.state = .ready
                case .error:
                    self.state = .ready
                    self.hasError = true
                case .ready:
                    debugPrint("UserSlotViewModel: ready")
            }
        }
    }

    init(UserIdUser: Int? = nil, SlotIdSlot: Int? = nil, zone: Int? = nil) {
        if let UserIdUser = UserIdUser {
            self.UserIdUser = UserIdUser
        }
        if let SlotIdSlot = SlotIdSlot {
            self.SlotIdSlot = SlotIdSlot
        }
        if let zone = zone {
            self.zone = zone
        }
        self.state = .ready
    }
    
}
