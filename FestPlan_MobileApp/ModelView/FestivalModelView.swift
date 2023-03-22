//
//  FestivalModelView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 21/03/2023.
//

import Combine
import Foundation

enum FestivalState {
    case ready
    case loadOpen(Festival)
    case error
}

class FestivalModelView : ObservableObject {
    
    @Published var idFestival = 0
    @Published var nameFestival = ""
    @Published var year = 0
    @Published var nbDays = 0
    @Published var isOpen = false
    @Published var hasError = false
    
    @Published var state : FestivalState = .ready {
        didSet {
            switch state {
                case .loadOpen(let newFestival):
                    self.idFestival = newFestival.idFestival
                    self.nameFestival = newFestival.nameFestival
                    self.year = newFestival.year
                    self.nbDays = newFestival.nbDays
                    self.isOpen = newFestival.isOpen
                    self.state = .ready
                case .error:
                    self.state = .ready
                    self.hasError = true
                case .ready:
                    debugPrint("FestivalViewModel: ready")
            }
        }
    }

    init(idFestival: Int? = nil, nameFestival: String? = nil, year: Int? = nil, nbDays: Int? = nil, isOpen: Bool? = nil) {
        if let idFestival = idFestival {
            self.idFestival = idFestival
        }
        if let nameFestival = nameFestival {
            self.nameFestival = nameFestival
        }
        if let year = year {
            self.year = year
        }
        if let nbDays = nbDays {
            self.nbDays = nbDays
        }
        if let isOpen = isOpen {
            self.isOpen = isOpen
        }
        self.state = .ready
    }
    
}
