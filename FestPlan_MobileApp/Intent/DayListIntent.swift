//
//  DayListIntent.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 25/03/2023.
//

import Foundation
import SwiftUI

struct DayListIntent {
    
    @ObservedObject private var model : DayListModelView
    
    init(dayList: DayListModelView){
        self.model = dayList
    }
    
    func load(festival: Int){
        DayService().getDay(festival: festival) { result in
            DispatchQueue.main.async {
                self.model.state = .load(result)
            }
        }
        DispatchQueue.main.async {
            self.model.state = .ready
        }
    }
    
    func remove(day: Int) {
        DayService().deleteDay(idDay: day) { success, error in
            if !success {
                return
            }
        }
    }
    
}
