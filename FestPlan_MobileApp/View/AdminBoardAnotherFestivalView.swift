//
//  AdminBoardAnotherFestivalView.swift
//  FestPlan_MobileApp
//
//  Created by Loris Bouchez on 29/03/2023.
//

import SwiftUI

struct AdminBoardAnotherFestivalView: View {
    
    @ObservedObject var viewModel: FestivalModelView
    @ObservedObject var festivalPrime: FestivalModelView
    var intent: FestivalIntent
    var intentList: FestivalListIntent
    @State var isActive = false
    //@Environment(\.presentationMode) var presentationMode
    
    init(model: FestivalModelView,intentList: FestivalListIntent ,festival: FestivalModelView) {
        self.viewModel = model
        self.festivalPrime = festival
        self.intent = FestivalIntent(festival: model)
        self.intentList = intentList
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Festival n°\(viewModel.idFestival) - \(viewModel.nameFestival)")
                    .font(.system(size: 25))
                    .foregroundColor(.black)
                    .padding(40)
                    .background(Color.white)
                if viewModel.isOpen == true {
                    NavigationLink(destination: HomeBoardView(model: FestivalModelView()).navigationBarBackButtonHidden(true)) {
                        Text("Accueil")
                    }
                    .hidden()
                    .navigationBarItems(leading:
                                            Button("< Back") {
                        isActive = true
                        //presentationMode.wrappedValue.dismiss()
                    },
                                        trailing: NavigationLink(destination:  FestivalManagementView(model: FestivalListModelView(), festival: viewModel).navigationBarBackButtonHidden(true), isActive: $isActive) {
                        EmptyView()
                    })
                    
                    Button("Fermer ce festival") {
                        intent.closeOpen()
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    .padding(20)
                    .frame(width: 250)
                    .background(Color.red)
                    .cornerRadius(10)
                } else {
                    
                    NavigationLink(destination: HomeBoardView(model: FestivalModelView()).navigationBarBackButtonHidden(true)) {
                        Text("Accueil")
                    }
                    .hidden()
                    .navigationBarItems(leading:
                                            Button("< Back") {
                        isActive = true
                    },
                                        trailing: NavigationLink(destination:  FestivalManagementView(model: FestivalListModelView(), festival: festivalPrime).navigationBarBackButtonHidden(true), isActive: $isActive) {
                        EmptyView()
                    })
                    
                    Text("Festival non ouvert")
                    if !festivalPrime.isOpen {
                        Button("Ouvrir ce festival") {
                            intent.open()
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .padding(20)
                        .frame(width: 250)
                        .background(Color.green)
                        .cornerRadius(10)
                    }
                }
                NavigationLink(destination: VolunteerListView(model: UserListModelView())) {
                    Text("Lister bénévoles")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .padding(20)
                        .frame(width: 250)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                NavigationLink(destination: DayManagementView(model: DayListModelView(), festival: viewModel).navigationBarBackButtonHidden(true)) {
                    Text("Gestion des jours")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .padding(20)
                        .frame(width: 250)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                NavigationLink(destination: ZoneManagementView(model: ZoneListModelView(), festival: viewModel).navigationBarBackButtonHidden(true)) {
                    Text("Gestion des zones")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .padding(20)
                        .frame(width: 250)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                NavigationLink(destination: SlotManagementView(model: SlotListModelView(), festival: viewModel)) {
                    Text("Gestion des créneaux")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .padding(20)
                        .frame(width: 250)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                NavigationLink(destination: FestivalDetailView(content: viewModel, intent: intentList, festival: festivalPrime)) {
                    Text("Détails du festival")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .padding(20)
                        .frame(width: 250)
                        .background(Color.black)
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Admin Board")
        }
    }
}

struct AdminBoardAnotherFestivalView_Previews: PreviewProvider {
    static var previews: some View {
        AdminBoardAnotherFestivalView(model: FestivalModelView(),intentList: FestivalListIntent(festivalList: FestivalListModelView()), festival: FestivalModelView())
    }
}
