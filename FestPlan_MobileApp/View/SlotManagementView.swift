//
//  SlotManagementView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import SwiftUI

struct SlotManagementView: View {

    @ObservedObject var viewModel: SlotListModelView
    var festival: FestivalModelView
    var intent: SlotListIntent
    
    init(model: SlotListModelView, festival: FestivalModelView) {
        self.viewModel = model
        self.intent = SlotListIntent(slotList: model)
        self.festival = festival
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: AdminBoardView(model: festival).navigationBarBackButtonHidden(true)) {
                    Text("Retour")
                }
                NavigationLink(destination: SlotCreationView(content: SlotModelView(), intent: intent, festival: festival, listZone: ZoneListModelView(), listDay: DayListModelView())) {
                    Text("Ajouter créneaux")
                }
                List {
                    ForEach(viewModel.slots, id: \.self){item in
                        NavigationLink(destination: SlotDetailView(content: item, intent: intent, festival: festival)){
                            VStack{
                                Text("\(item.nameDay)")
                                Text("\(item.startHour)")
                                Text("\(item.endHour)")
                                Text("\(item.nameZone)")
                            }
                        }
                    }
                    .onDelete { indexSet in
                        let id = indexSet.map { viewModel.slots[$0].idSlot }
                        intent.remove(slot: id[0])
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            intent.load(festival: festival.idFestival)
        })
    }
}
