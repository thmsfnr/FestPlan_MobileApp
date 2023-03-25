//
//  ZoneSlotListModelView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 25/03/2023.
//

import Foundation

enum ZoneSlotListState {
    case ready
    case addUserSlot(ZoneSlotModelView)
    case signup(Int,Int)
    case error
}

class ZoneSlotListModelView: ObservableObject {
    
    @Published public var list: [ZoneSlotModelView] = []
    @Published public var hasError = false
    
    @Published var state : ZoneSlotListState = .ready {
        didSet {
            switch state {
                case .addUserSlot(let newList):
                    DispatchQueue.main.async {
                        self.list.append(newList)
                        self.state = .ready
                    }
            case .signup(let slot, let zone):
                    for item in list {
                        for i in 0..<item.slots.count {
                            if item.slots[i].idSlot == slot && item.idZone == zone {
                                item.slots.remove(at: i)
                            }
                        }
                        if item.slots.count == 0 {
                                if let index = list.firstIndex(where: { $0.idZone == item.idZone }) {
                                    list.remove(at: index)
                                }
                            }
                    }
                case .error:
                    self.state = .ready
                    self.hasError = true
                case .ready:
                    debugPrint("FestivalViewModel: ready")
            }
        }
    }
    
    subscript(index: Int) -> ZoneSlotModelView {
        get {
            return list[index]
        }
    }
    
    init(list: [ZoneSlotModelView]? = nil) {
        if let list = list {
            self.list = list
        }
    }

}
