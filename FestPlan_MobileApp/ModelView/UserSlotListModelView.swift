//
//  UserSlotListModelView.swift
//  FestPlan_MobileApp
//
//  Created by etud on 24/03/2023.
//

import Foundation

enum UserSlotListState {
    case ready
    case loadUser(UserSlot,String)
    case error
}

class UserSlotListModelView: ObservableObject {
    
    @Published public var list: [UserSlotModelView] = []
    @Published public var hasError = false
    
    @Published var state : UserSlotListState = .ready {
        didSet {
            switch state {
                case .loadUser(let list2, let name):
                    list.append(UserSlotModelView(UserIdUser: list2.UserIdUser, SlotIdSlot: list2.SlotIdSlot, zone: list2.zone, nameZone: list2.Zone?.nameZone, nameDay: name, startHour: list2.Slot?.startHour, endHour: list2.Slot?.endHour))
                    self.state = .ready
                case .error:
                    self.state = .ready
                    self.hasError = true
                case .ready:
                    debugPrint("UserSlotListViewModel: ready")
            }
        }
    }
    
    subscript(index: Int) -> UserSlotModelView {
        get {
            return list[index]
        }
    }
    
    init(list: [UserSlotModelView]? = nil) {
        if let list = list {
            self.list = list
        }
    }

}
