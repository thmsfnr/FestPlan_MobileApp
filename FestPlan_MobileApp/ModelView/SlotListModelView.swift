//
//  SlotListModelView.swift
//  FestPlan_MobileApp
//
//  Created by Loris on 24/03/2023.
//

import Foundation

enum SlotListState {
    case ready
    case load(Slot)
    case error
}

class SlotListModelView : ObservableObject{
    
    @Published public var slots : [SlotModelView] = []
    
    init(slots: [SlotModelView]) {
        self.slots = slots
    }
    
    @Published var state : SlotListState = .ready {
        didSet {
            switch state {
                case .load(let newElem):
                    for elem in slots {
                        if elem.idSlot == newElem.idSlot {
                            return
                        }
                    }
                let newModelView = SlotModelView(idSlot: newElem.idSlot, startHour: newElem.startHour, endHour: newElem.endHour, day: newElem.day, zone: newElem.zone, nameDay: newElem.Day?.nameDay, nameZone: newElem.Zone?.nameZone)
                    slots.append(newModelView)
                    self.state = .ready
                case .error:
                    self.state = .ready
                case .ready:
                    debugPrint("FestivalViewModel: ready")
            }
        }
    }
    
    subscript(index: Int) -> SlotModelView {
        get {
            return slots[index]
        }
    }
    
    init(list: [SlotModelView]? = nil) {
        if let list = list {
            self.slots = list
        }
    }
    
}
