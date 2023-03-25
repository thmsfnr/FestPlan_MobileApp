//
//  UserSlotListModelView.swift
//  FestPlan_MobileApp
//
//  Created by etud on 24/03/2023.
//

import Foundation

enum UserSlotListState {
    case ready
    case loadUser([UserSlot])
    case error
}

class UserSlotListModelView: ObservableObject {
    
    @Published public var list: [UserSlotModelView] = []
    @Published public var hasError = false
    
    @Published var state : UserSlotListState = .ready {
        didSet {
            switch state {
                case .loadUser(let newList):
                    for elem in newList {
                        let newModelView = UserSlotModelView(UserIdUser: elem.UserIdUser, SlotIdSlot: elem.SlotIdSlot, zone: elem.zone)
                        list.append(newModelView)
                    }
                    self.state = .ready
                case .error:
                    self.state = .ready
                    self.hasError = true
                case .ready:
                    debugPrint("FestivalViewModel: ready")
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