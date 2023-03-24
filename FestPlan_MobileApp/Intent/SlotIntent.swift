//
//  SlotIntent.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import SwiftUI

struct SlotIntent {
    
    @ObservedObject private var model : SlotModelView
    init(slot: SlotModelView){
        self.model = slot
    }
    /*
    func loadOpen(){
        SlotService().getSlot(idSlot: <#T##Int?#>) { result in
            DispatchQueue.main.async {
                self.model.state = .loadOpen(result[0])
            }
        }
        DispatchQueue.main.async {
            self.model.state = .ready
        }
    }*/
    
}
