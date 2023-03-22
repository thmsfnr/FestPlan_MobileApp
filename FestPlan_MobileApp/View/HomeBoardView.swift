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
    @State var festival = 0
    
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
                NavigationLink(destination: DisplayRegistrationView()) {
                    Text("Mes inscriptions")
                }
                NavigationLink(destination: SignupRegistrationView()) {
                    Text("M'inscrire")
                }
                if viewModel.isOpen == true {
                    Text("Festival n°\(viewModel.idFestival) - \(viewModel.nameFestival)")
                } else {
                    Text("Loading festival...")
                }
            }
            .navigationBarTitle("Accueil")
            .onAppear(perform: {
                intent.loadOpen()
            })
        }
    }
}

struct HomeBoardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBoardView(model: FestivalModelView())
    }
}
