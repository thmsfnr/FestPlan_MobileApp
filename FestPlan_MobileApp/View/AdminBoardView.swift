//
//  AdminBoardView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import SwiftUI

struct AdminBoardView: View {
    
    @ObservedObject var viewModel: FestivalModelView
    var intent: FestivalIntent
    
    init(model: FestivalModelView) {
        self.viewModel = model
        self.intent = FestivalIntent(festival: model)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isOpen == true {
                    Text("Festival n°\(viewModel.idFestival) - \(viewModel.nameFestival)")
                    Button("Fermer ce festival") {
                        intent.closeOpen()
                    }
                } else {
                    Text("Pas de festival")
                }
                NavigationLink(destination: VolunteerListView()) {
                    Text("Lister bénévoles")
                }
                NavigationLink(destination: DayManagementView(model: DayListModelView(), festival: viewModel).navigationBarBackButtonHidden(true)) {
                    Text("Gestion des jours")
                }
                NavigationLink(destination: ZoneManagementView()) {
                    Text("Gestion des zones")
                }
                NavigationLink(destination: SlotManagementView()) {
                    Text("Gestion des créneaux")
                }
                NavigationLink(destination: FestivalManagementView()) {
                    Text("Tous les festivals")
                }
                NavigationLink(destination: HomeBoardView(model: FestivalModelView()).navigationBarBackButtonHidden(true)) {
                    Text("Retour")
                }
            }
            .navigationBarTitle("Admin Board")
        }
    }
}

struct AdminBoardView_Previews: PreviewProvider {
    static var previews: some View {
        AdminBoardView(model: FestivalModelView())
    }
}
