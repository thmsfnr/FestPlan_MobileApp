//
//  UserSlotIntent.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import SwiftUI

struct UserSlotIntent {
    
    @ObservedObject private var model : UserSlotModelView
    init(userSlot: UserSlotModelView){
        self.model = userSlot
    }
    
    func loadZone(zone: Int){
        UserSlotService().getUserSlot(zone: zone) { result in
            DispatchQueue.main.async {
                if result.count != 0 {
                    self.model.state = .loadZone(result[0])
                }
            }
        }
        DispatchQueue.main.async {
            self.model.state = .ready
        }
    }
    
}
