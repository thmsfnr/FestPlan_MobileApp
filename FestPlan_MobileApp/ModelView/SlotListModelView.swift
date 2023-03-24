//
//  SlotListModelView.swift
//  FestPlan_MobileApp
//
//  Created by Loris on 24/03/2023.
//

import Foundation

class SlotListModelView : ObservableObject{
    
    @Published public var slots : [SlotModelView]
    
    init(slots: [SlotModelView]) {
        self.slots = slots
    }
    
}
