//
//  AdminBoardAnotherFestivalView.swift
//  FestPlan_MobileApp
//
//  Created by etud on 29/03/2023.
//

import SwiftUI

struct AdminBoardAnotherFestivalView: View {
    
    @ObservedObject var viewModel: FestivalModelView
    @ObservedObject var festivalPrime: FestivalModelView
    var intent: FestivalIntent
    var intentList: FestivalListIntent
    
    init(model: FestivalModelView,intentList: FestivalListIntent ,festival: FestivalModelView) {
        self.viewModel = festival
        self.festivalPrime = model
        self.intent = FestivalIntent(festival: model)
        self.intentList = intentList
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
                NavigationLink(destination: VolunteerListView(model: UserListModelView())) {
                    Text("Lister bénévoles")
                }
                NavigationLink(destination: DayManagementView(model: DayListModelView(), festival: viewModel).navigationBarBackButtonHidden(true)) {
                    Text("Gestion des jours")
                }
                NavigationLink(destination: ZoneManagementView(model: ZoneListModelView(), festival: viewModel).navigationBarBackButtonHidden(true)) {
                    Text("Gestion des zones")
                }
                NavigationLink(destination: SlotManagementView()) {
                    Text("Gestion des créneaux")
                }
                NavigationLink(destination: FestivalDetailView(content: viewModel, intent: intentList, festival: festivalPrime).navigationBarBackButtonHidden(true)) {
                    Text("Détails du festival")
                }
            }
            .navigationBarTitle("Admin Board of "+"\(viewModel.nameFestival)")
        }
    }
}

struct AdminBoardAnotherFestivalView_Previews: PreviewProvider {
    static var previews: some View {
        AdminBoardAnotherFestivalView(model: FestivalModelView(),intentList: FestivalListIntent(festivalList: FestivalListModelView()), festival: FestivalModelView())
    }
}
