//
//  FestivalCreationView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import SwiftUI

struct FestivalCreationView: View {
    
    @State var content: FestivalModelView
    var intent: FestivalListIntent
    var festivalPrime: FestivalModelView
    @State private var showNewView = false
    
    init(content: FestivalModelView, intent: FestivalListIntent, festival : FestivalModelView) {
        self.content = content
        self.intent = intent
        self.festivalPrime = festival
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: FestivalManagementView(model: FestivalListModelView(), festival: festivalPrime).navigationBarBackButtonHidden(true)) {
                    Text("Retour")
                }
                Text("Nom du festival")
                TextField("Nom du festival", text: $content.nameFestival)
                Text("Année de l'évènement")
                TextField("Année de l'évènement", value: $content.year, formatter: NumberFormatter())
                Text("Nombre de jour(s) de l'évènement")
                TextField("Nombre de jour(s) de l'évènement", value: $content.nbDays, formatter: NumberFormatter())
                NavigationLink(
                    destination: FestivalManagementView(model: FestivalListModelView(), festival: festivalPrime).navigationBarBackButtonHidden(true),
                    isActive: $showNewView,
                    label: {
                        Button("Valider") {
                            intent.create(nameFestival: content.nameFestival, year: content.year, nbDays: content.nbDays)
                            sleep(1)
                            showNewView = true
                        }
                    }).navigationBarBackButtonHidden(true)
            }
        }.navigationBarBackButtonHidden(true)
    }
}


struct FestivalCreationView_Previews: PreviewProvider {
    static var previews: some View {
        FestivalCreationView(content: FestivalModelView(), intent: FestivalListIntent(festivalList: FestivalListModelView()), festival: FestivalModelView())
    }
}
