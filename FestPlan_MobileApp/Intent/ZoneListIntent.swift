//
//  ZoneListIntent.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 27/03/2023.
//

import Foundation
import SwiftUI

struct ZoneListIntent {
    
    @ObservedObject private var model : ZoneListModelView
    
    init(zoneList: ZoneListModelView){
        self.model = zoneList
    }
    
    func load(festival: Int){
        ZoneService().getZone(festival: festival) { result in
            DispatchQueue.main.async {
                self.model.state = .load(result)
            }
        }
        DispatchQueue.main.async {
            self.model.state = .ready
        }
    }
    
    func remove(zone: Int) {
        ZoneService().deleteZone(idZone: zone) { success, error in
            if !success {
                return
            }
        }
    }
    
    func update(idZone: Int, nameZone: String, maxVolunteers: Int) {
        ZoneService().updateZone(idZone: idZone, nameZone: nameZone, maxVolunteers: maxVolunteers) { success, error in
            if !success {
                DispatchQueue.main.async {
                    self.model.state = .ready
                }
                return
            }
            DispatchQueue.main.async {
                self.model.state = .update(idZone)
            }
        }
    }
    
    func create(nameZone: String, maxVolunteers: Int, festival: Int) {
        ZoneService().createZone(nameZone: nameZone, maxVolunteers: maxVolunteers, festival: festival) { success, error in
            if !success {
                return
            }
            DispatchQueue.main.async {
                self.model.state = .ready
            }
        }
    }
    
}
