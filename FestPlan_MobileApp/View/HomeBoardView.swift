//
//  HomeBoardView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 18/03/2023.
//

import SwiftUI

struct HomeBoardView: View {
    
    @ObservedObject var viewModel: FestivalModelView
    var intent: FestivalIntent
    
    init(model: FestivalModelView) {
        self.viewModel = model
        self.intent = FestivalIntent(festival: model)
    }
    
    @State var shouldLogout = false
    @State var isAdmin = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), isActive: $shouldLogout) {
                    EmptyView()
                }
                .hidden()
                .navigationBarItems(trailing:
                    Button(action: {
                        UserDefaults.standard.set(nil, forKey: "user")
                        shouldLogout = true
                    }) {
                        Text("Logout")
                    }
                )
                if viewModel.isOpen == true {
                    Text("Festival n°\(viewModel.idFestival) - \(viewModel.nameFestival)")
                    NavigationLink(destination: DisplayRegistrationView(model: UserSlotListModelView(), festival: viewModel.idFestival)) {
                        Text("Mes inscriptions")
                    }
                    NavigationLink(destination: SignupRegistrationView(model: ZoneSlotListModelView(), festival: viewModel.idFestival)) {
                        Text("M'inscrire")
                    }
                } else {
                    Text("Pas de festival")
                }
                if isAdmin == true {
                    NavigationLink(destination: AdminBoardView(model: viewModel)) {
                        Text("Admin")
                    }
                }
            }
            .navigationBarTitle("Accueil")
            .onAppear(perform: {
                intent.loadOpen()
                TestService().isAdmin() { success, error in
                    if !success {
                        return
                    }
                    DispatchQueue.main.async {
                        isAdmin = true
                    }
                }
            })
        }
    }
}

struct HomeBoardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBoardView(model: FestivalModelView())
    }
}
