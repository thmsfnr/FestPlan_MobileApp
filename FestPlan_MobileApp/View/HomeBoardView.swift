//
//  HomeBoardView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 18/03/2023.
//

import SwiftUI

struct HomeBoardView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SignInView().navigationBarBackButtonHidden(true)) {
                    Text("Logout")
                }
                .onTapGesture {
                    UserDefaults.standard.set(nil, forKey: "user")
                }
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
