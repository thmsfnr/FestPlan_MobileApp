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
                NavigationLink(destination: DayCreationView(content: DayModelView(), intent: intent, festival: festival)) {
                    Text("Ajouter créneaux")
                }
                List {
                    ForEach(viewModel.list, id: \.self){item in
                        NavigationLink(destination: DayDetailView(content: item, intent: intent, festival: festival)){
                            VStack{
                                Text("\(item.nameDay)")
                                Text("\(item.startHour)")
                                Text("\(item.endHour)")
                                Text("\(item.nameZone)")
                            }
                        }
                    }
                    .onDelete { indexSet in
                        let id = indexSet.map { viewModel.list[$0].idSlot }
                        intent.remove(day: id[0])
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            intent.load(festival: festival.idFestival)
        })
    }
}
