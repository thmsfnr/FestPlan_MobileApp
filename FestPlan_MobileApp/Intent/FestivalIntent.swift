//
//  FestivalIntent.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 21/03/2023.
//

import SwiftUI

struct FestivalIntent {
    
    @ObservedObject private var model : FestivalModelView
    init(festival: FestivalModelView){
        self.model = festival
    }
    
    func loadOpen(){
        FestivalService().getFestival(isOpen: true) { result in
            DispatchQueue.main.async {
                if result.count != 0 {
                    self.model.state = .loadOpen(result[0])
                }
            }
        }
        DispatchQueue.main.async {
            self.model.state = .ready
        }
    }
    
    func closeOpen(){
        FestivalService().updateFestival(idFestival: model.idFestival, isOpen: false) { success, error in
            if !success {
                return
            }
            else {
                DispatchQueue.main.async {
                    self.model.state = .closeOpen
                }
            }
        }
    }
    
}
