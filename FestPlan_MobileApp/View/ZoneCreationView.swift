//
//  ZoneCreationView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import SwiftUI

struct ZoneCreationView: View {
    
    @State var content: ZoneModelView
    var intent: ZoneListIntent
    var festival: FestivalModelView
    @State private var showNewView = false
    
    init(content: ZoneModelView, intent: ZoneListIntent, festival: FestivalModelView) {
        self.content = content
        self.intent = intent
        self.festival = festival
    }

    var body: some View {
        NavigationView {
            VStack {
                /*
                NavigationLink(destination: ZoneManagementView(model: ZoneListModelView(), festival: festival).navigationBarBackButtonHidden(true)) {
                    Text("Retour")
                }
                 */
                TextField("Nom de la zone", text: $content.nameZone)
                TextField("Nombre max de bénévoles", value: $content.maxVolunteers, formatter: NumberFormatter())
                NavigationLink(
                                destination: ZoneManagementView(model: ZoneListModelView(), festival: festival).navigationBarBackButtonHidden(true),
                                isActive: $showNewView,
                                label: {
                                    Button("Valider") {
                                        intent.create(nameZone: content.nameZone, maxVolunteers: content.maxVolunteers, festival: festival.idFestival)
                                        sleep(1)
                                        showNewView = true
                                    }
                                }).navigationBarBackButtonHidden(true)
            }
        }//.navigationBarBackButtonHidden(true)
    }
}

struct ZoneCreationView_Previews: PreviewProvider {
    static var previews: some View {
        ZoneCreationView(content: ZoneModelView(), intent: ZoneListIntent(zoneList: ZoneListModelView()), festival: FestivalModelView())
    }
}
