//
//  HomeBoardView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 18/03/2023.
//

import SwiftUI

struct HomeBoardView: View {
    @State var shouldLogout = false
    
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
            }
            .navigationBarTitle("Home")
        }
    }
}

struct HomeBoardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBoardView()
    }
}
