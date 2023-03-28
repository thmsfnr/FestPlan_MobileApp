//
//  FestivalListModelView.swift
//  FestPlan_MobileApp
//
//  Created by etud on 28/03/2023.
//

import Foundation

enum FestivalListState {
    case ready
    case load([Festival])
    case update(Int)
    case error
}

class FestivalListModelView: ObservableObject {
    
    @Published public var list: [FestivalModelView] = []
    @Published public var hasError = false
    
    @Published var state : FestivalListState = .ready {
        didSet {
            switch state {
                case .load(let newList):
                    var save: [FestivalModelView] = []
                    for elem in newList {
                        let newModelView = FestivalModelView(idFestival: elem.idFestival, nameFestival: elem.nameFestival, year : elem.year, nbDays: elem.nbDays, isOpen: elem.isOpen)
                        save.append(newModelView)
                    }
                    list = save
                    self.state = .ready
                case .update(let festival):
                    self.state = .ready
                case .error:
                    self.state = .ready
                    self.hasError = true
                case .ready:
                    debugPrint("FestivalViewModel: ready")
            }
        }
    }
    
    subscript(index: Int) -> FestivalModelView {
        get {
            return list[index]
        }
    }
    
    init(list: [FestivalModelView]? = nil) {
        if let list = list {
            self.list = list
        }
    }

}
