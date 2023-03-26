//
//  DayListModelView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 25/03/2023.
//

import Foundation

enum DayListState {
    case ready
    case load([Day])
    case update(Int)
    case error
}

class DayListModelView: ObservableObject {
    
    @Published public var list: [DayModelView] = []
    @Published public var hasError = false
    
    @Published var state : DayListState = .ready {
        didSet {
            switch state {
                case .load(let newList):
                    var save: [DayModelView] = []
                    for elem in newList {
                        let newModelView = DayModelView(idDay: elem.idDay, nameDay: elem.nameDay, startHour: elem.startHour, endHour: elem.endHour, festival: elem.festival)
                        save.append(newModelView)
                    }
                    list = save
                    self.state = .ready
                case .update(let day):
                    self.state = .ready
                case .error:
                    self.state = .ready
                    self.hasError = true
                case .ready:
                    debugPrint("FestivalViewModel: ready")
            }
        }
    }
    
    subscript(index: Int) -> DayModelView {
        get {
            return list[index]
        }
    }
    
    init(list: [DayModelView]? = nil) {
        if let list = list {
            self.list = list
        }
    }

}
