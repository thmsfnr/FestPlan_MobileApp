//
//  ZoneModelView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import Combine
import Foundation

/*enum ZoneState {
    case ready
    case loadFestival(Zone)
    case error
}

class ZoneModelView : ObservableObject {
    
    @Published var idZone = 0
    @Published var nameZone = ""
    @Published var maxVolunteers = 0
    @Published var festival = 0
    @Published var hasError = false
    
    @Published var state : ZoneState = .ready {
        didSet {
            switch state {
                case .loadFestival(let newZone):
                    self.idZone = newZone.idZone
                    self.startHour = newZone.startHour
                    self.endHour = newZone.endHour
                    self.day = newZone.day
                    self.zone = newZone.isOpen
                    self.state = .ready
                case .error:
                    self.state = .ready
                    self.hasError = true
                case .ready:
                    debugPrint("FestivalViewModel: ready")
            }
        }
    }

    init(idZone: Int? = nil, startHour: String? = nil, endHour: String? = nil, day: Int? = nil, zone: Int? = nil) {
        if let idZone = idZone {
            self.idZone = idZone
        }
        if let startHour = startHour {
            self.startHour = startHour
        }
        if let endHour = endHour {
            self.endHour = endHour
        }
        if let day = day {
            self.day = day
        }
        if let zone = zone {
            self.zone = zone
        }
        self.state = .ready
    }
    
}*/
