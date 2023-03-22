//
//  ContentView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 18/03/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Group {
            if UserDefaults.standard.data(forKey: "user") == nil {
                SignInView(model: UserModelView())
            } else {
                HomeBoardView(model: FestivalModelView())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
