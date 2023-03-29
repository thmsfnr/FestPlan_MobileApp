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
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                        .padding(40)
                        .background(Color.white)
                    Button("Fermer ce festival") {
                        intent.closeOpen()
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    .padding(20)
                    .frame(width: 250)
                    .background(Color.black)
                    .cornerRadius(10)
                    NavigationLink(destination: DayManagementView(model: DayListModelView(), festival: viewModel).navigationBarBackButtonHidden(true)) {
                        Text("Gérer les jours")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                            .padding(20)
                            .frame(width: 250)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: ZoneManagementView(model: ZoneListModelView(), festival: viewModel).navigationBarBackButtonHidden(true)) {
                        Text("Gérer les zones")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                            .padding(20)
                            .frame(width: 250)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: SlotManagementView()) {
                        Text("Gérer les créneaux")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                            .padding(20)
                            .frame(width: 250)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                } else {
                    Text("Pas de festival")
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                        .padding(40)
                        .background(Color.white)
                }
                NavigationLink(destination: VolunteerListView(model: UserListModelView())) {
                    Text("Voir les bénévoles")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .padding(20)
                        .frame(width: 250)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                NavigationLink(destination: FestivalManagementView(model: FestivalListModelView(), festival: viewModel).navigationBarBackButtonHidden(true)) {
                    Text("Gérer les festivals")
                    .foregroundColor(.white)
                        .font(.system(size: 25))
                        .padding(20)
                        .frame(width: 250)
                        .background(Color.black)
                        .cornerRadius(10)
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
