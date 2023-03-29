//
//  FestivalListIntent.swift
//  FestPlan_MobileApp
//
//  Created by Loris Bouchez on 28/03/2023.
//

import Foundation
import SwiftUI

struct FestivalListIntent {
    
    @ObservedObject private var model : FestivalListModelView
    
    init(festivalList: FestivalListModelView){
        self.model = festivalList
    }
    
    func load(festival: Int){
        FestivalService().getFestival() { result in
            DispatchQueue.main.async {
                self.model.state = .load(result)
            }
        }
        DispatchQueue.main.async {
            self.model.state = .ready
        }
    }
    
    func remove(festival: Int) {
        FestivalService().deleteFestival(idFestival: festival) { success, error in
            if !success {
                return
            }
        }
    }
    
    func update(idFestival: Int, nameFestival: String, year: Int, nbDays: Int, isOpen: Bool) {
        FestivalService().updateFestival(idFestival: idFestival, nameFestival: nameFestival, year : year, nbDays: nbDays, isOpen: isOpen) { success, error in
            if !success {
                DispatchQueue.main.async {
                    self.model.state = .ready
                }
                return
            }
            DispatchQueue.main.async {
                self.model.state = .update(idFestival)
            }
        }
    }
    
    func create(nameFestival: String, year: Int, nbDays: Int) {
        FestivalService().createFestival(nameFestival: nameFestival, year : year, nbDays: nbDays, isOpen: 0) { success, error in
            if !success {
                return
            }
            DispatchQueue.main.async {
                self.model.state = .ready
            }
        }
    }
    
}
