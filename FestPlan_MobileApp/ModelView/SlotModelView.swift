//
//  SlotModelView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import Combine
import Foundation

enum SlotState {
    case ready
    case loadOpen(Slot)
    case error
}

class SlotModelView : ObservableObject {
    
    @Published var idSlot = 0
    @Published var startHour = ""
    @Published var endHour = ""
    @Published var day = 0
    @Published var zone = 0
    @Published var nameZone = ""
    @Published var hasError = false
    
    @Published var state : SlotState = .ready{
        didSet {
            switch state {
                case .loadOpen(let newSlot):
                    self.idSlot = newSlot.idSlot
                    self.startHour = newSlot.startHour
                    self.endHour = newSlot.endHour
                    self.day = newSlot.day
                    self.zone = newSlot.zone
                    self.nameZone = nameZone
                    self.state = .ready
                case .error:
                    self.state = .ready
                    self.hasError = true
                case .ready:
                debugPrint("SlotViewModel: ready")
            }
            
        }
    }
    
    init(idSlot: Int? = nil, startHour: String? = nil, endHour: String? = nil, day: Int?, zone: Int?  ) {
        if let idSlot = idSlot {
            self.idSlot = idSlot
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
    
}
