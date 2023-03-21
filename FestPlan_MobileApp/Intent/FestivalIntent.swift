//
//  FestivalIntent.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 21/03/2023.
//

import SwiftUI

struct FestivalIntent {
    
    @ObservedObject private var model : FestivalViewModel
    init(festival: FestivalViewModel){
        self.model = festival
    }
    
    func loadOpen(){
        FestivalService().getFestival(isOpen: true) { result in
            DispatchQueue.main.async {
                self.model.state = .loadOpen(result[0])
            }
        }
        DispatchQueue.main.async {
            self.model.state = .ready
        }
    }
    
}
