//
//  DayCreationView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import SwiftUI

struct DayCreationView: View {
    
    @State var content: DayModelView
    var intent: DayListIntent
    var festival: FestivalModelView
    @State private var showNewView = false
    
    init(content: DayModelView, intent: DayListIntent, festival: FestivalModelView) {
        self.content = content
        self.intent = intent
        self.festival = festival
    }

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: DayManagementView(model: DayListModelView(), festival: festival).navigationBarBackButtonHidden(true)) {
                    Text("Retour")
                }
                TextField("Nom du jour", text: $content.nameDay)
                TextField("Heure de départ", text: $content.startHour)
                TextField("Heure de fin", text: $content.endHour)
                NavigationLink(
                                destination: DayManagementView(model: DayListModelView(), festival: festival).navigationBarBackButtonHidden(true),
                                isActive: $showNewView,
                                label: {
                                    Button("Valider") {
                                        intent.create(nameDay: content.nameDay, startHour: content.startHour, endHour: content.endHour, festival: festival.idFestival)
                                        sleep(1)
                                        showNewView = true
                                    }
                                }).navigationBarBackButtonHidden(true)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct DayCreationView_Previews: PreviewProvider {
    static var previews: some View {
        DayCreationView(content: DayModelView(), intent: DayListIntent(dayList: DayListModelView()), festival: FestivalModelView())
    }
}
