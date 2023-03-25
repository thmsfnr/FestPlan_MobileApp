//
//  DayModelView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import Combine
import Foundation

class DayModelView : ObservableObject, Equatable, Hashable {
    
    @Published var idDay = 0
    @Published var nameDay = ""
    @Published var startHour = ""
    @Published var endHour = ""
    @Published var festival = 0

    init(idDay: Int? = nil, nameDay: String? = nil, startHour: String? = nil, endHour: String? = nil, festival: Int? = nil) {
        if let idDay = idDay {
            self.idDay = idDay
        }
        if let nameDay = nameDay {
            self.nameDay = nameDay
        }
        if let startHour = startHour {
            self.startHour = startHour
        }
        if let endHour = endHour {
            self.endHour = endHour
        }
        if let festival = festival {
            self.festival = festival
        }
    }
    
    static func == (lhs: DayModelView, rhs: DayModelView) -> Bool {
        return lhs.idDay == rhs.idDay
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.idDay)
    }
    
}
