//
//  HomeBoardView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 18/03/2023.
//

import SwiftUI

struct HomeBoardView: View {
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
                Text("Festival n°\(festival)")
            }
            .navigationBarTitle("Accueil")
            .onAppear(perform: {
                FestivalService().createFestival(nameFestival: "test") {
                    success, error in
                        if !success {
                            print("yesssss")
                        }
                        else {
                            print("shiitt")
                        }
                }
                FestivalService().getFestival(isOpen: true) { result in
                    DispatchQueue.main.async {
                        self.festival = result[0].idFestival
                    }
                }
            })
        }
    }
}

struct HomeBoardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBoardView()
    }
}
