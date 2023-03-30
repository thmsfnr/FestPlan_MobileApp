//
//  SlotCreationView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import SwiftUI

struct SlotCreationView: View {
    
    @State var content: SlotModelView
    var intent: SlotListIntent
    var festival: FestivalModelView
    @ObservedObject var listZone: ZoneListModelView
    @ObservedObject var listDay: DayListModelView
    var dayIntent: DayListIntent
    var zoneIntent: ZoneListIntent
    @State private var showNewView = false
    @State private var selectedDay = 0
    @State private var selectedZone = 0
    
    
    init(content: SlotModelView, intent: SlotListIntent, festival: FestivalModelView, listZone: ZoneListModelView, listDay: DayListModelView) {
        self.content = content
        self.intent = intent
        self.festival = festival
        self.listZone = listZone
        self.listDay = listDay
        self.dayIntent = DayListIntent(dayList: listDay)
        self.zoneIntent = ZoneListIntent(zoneList: listZone)
    }

    var body: some View {
        NavigationView {
            VStack {
                /*
                NavigationLink(destination: SlotManagementView(model: SlotListModelView(), festival: festival).navigationBarBackButtonHidden(true)) {
                    Text("Retour")
                }
                 */
                Picker(selection: $selectedDay, label: Text("Select a day")) {
                    ForEach(listDay.list, id: \.self) { index in
                        Text(index.nameDay).tag(index.idDay)
                    }
                }
                Picker(selection: $selectedZone, label: Text("Select a zone")) {
                    ForEach(listZone.list, id: \.self) { index in
                        Text(index.nameZone).tag(index.idZone)
                    }
                }
                                    
                TextField("Heure de départ", text: $content.startHour)
                TextField("Heure de fin", text: $content.endHour)
                NavigationLink(
                                destination: SlotManagementView(model: SlotListModelView(), festival: festival).navigationBarBackButtonHidden(true),
                                isActive: $showNewView,
                                label: {
                                    Button("Valider") {
                                        intent.create(startHour: content.startHour, endHour: content.endHour, day: selectedDay, zone: selectedZone)
                                        sleep(1)
                                        showNewView = true
                                    }
                                }).navigationBarBackButtonHidden(true)
            }
        }//.navigationBarBackButtonHidden(true)
        .navigationBarTitle("Créanaux - Création")
            .onAppear(perform: {
                dayIntent.load(festival: festival.idFestival)
                zoneIntent.load(festival: festival.idFestival)
            })
        
    }
}

struct SlotCreationView_Previews: PreviewProvider {
    static var previews: some View {
        SlotCreationView(content: SlotModelView(), intent: SlotListIntent(slotList: SlotListModelView()), festival: FestivalModelView(), listZone: ZoneListModelView(), listDay: DayListModelView())
    }
}
