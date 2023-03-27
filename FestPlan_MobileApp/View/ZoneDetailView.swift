//
//  ZoneDetailView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import SwiftUI

struct ZoneDetailView: View {
    
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
                TextField("Nom de la zone", text: $content.nameZone)
                TextField("Nombre max de bénévoles", value: $content.maxVolunteers, formatter: NumberFormatter())
                NavigationLink(
                                destination: ZoneManagementView(model: ZoneListModelView(), festival: festival),
                                isActive: $showNewView,
                                label: {
                                    Button("Valider") {
                                        intent.update(idZone: content.idZone, nameZone: content.nameZone, maxVolunteers: content.maxVolunteers)
                                        showNewView = true
                                    }
                                })
            }
        }
    }
}

struct ZoneDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ZoneDetailView(content: ZoneModelView(), intent: ZoneListIntent(zoneList: ZoneListModelView()), festival: FestivalModelView())
    }
}
