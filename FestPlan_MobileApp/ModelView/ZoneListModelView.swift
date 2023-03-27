//
//  ZoneListModelView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 27/03/2023.
//

import Foundation

enum ZoneListState {
    case ready
    case load([Zone])
    case update(Int)
    case error
}

class ZoneListModelView: ObservableObject {
    
    @Published public var list: [ZoneModelView] = []
    @Published public var hasError = false
    
    @Published var state : ZoneListState = .ready {
        didSet {
            switch state {
                case .load(let newList):
                    var save: [ZoneModelView] = []
                    for elem in newList {
                        let newModelView = ZoneModelView(idZone: elem.idZone, nameZone: elem.nameZone, maxVolunteers: elem.maxVolunteers, festival: elem.festival)
                        save.append(newModelView)
                    }
                    list = save
                    self.state = .ready
                case .update(let zone):
                    self.state = .ready
                case .error:
                    self.state = .ready
                    self.hasError = true
                case .ready:
                    debugPrint("FestivalViewModel: ready")
            }
        }
    }
    
    subscript(index: Int) -> ZoneModelView {
        get {
            return list[index]
        }
    }
    
    init(list: [ZoneModelView]? = nil) {
        if let list = list {
            self.list = list
        }
    }

}
