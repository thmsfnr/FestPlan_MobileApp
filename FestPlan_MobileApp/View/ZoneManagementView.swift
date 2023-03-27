//
//  ZoneManagementView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import SwiftUI

struct ZoneManagementView: View {
    
    @ObservedObject var viewModel: ZoneListModelView
    var festival: FestivalModelView
    var intent: ZoneListIntent
    
    init(model: ZoneListModelView, festival: FestivalModelView) {
        self.viewModel = model
        self.intent = ZoneListIntent(zoneList: model)
        self.festival = festival
    }

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: AdminBoardView(model: festival).navigationBarBackButtonHidden(true)) {
                    Text("Retour")
                }
                NavigationLink(destination: ZoneCreationView(content: ZoneModelView(), intent: intent, festival: festival).navigationBarBackButtonHidden(true)) {
                    Text("Ajouter zone")
                }
                List {
                    ForEach(viewModel.list, id: \.self){item in
                        NavigationLink(destination: ZoneDetailView(content: item, intent: intent, festival: festival)){
                            VStack{
                                Text("\(item.nameZone)")
                                Text("\(item.maxVolunteers)")
                            }
                        }
                    }
                    .onDelete { indexSet in
                        let id = indexSet.map { viewModel.list[$0].idZone }
                        intent.remove(zone: id[0])
                    }
                }
            }
        }
        .onAppear(perform: {
            intent.load(festival: festival.idFestival)
        })
    }
}

struct ZoneManagementView_Previews: PreviewProvider {
    static var previews: some View {
        ZoneManagementView(model: ZoneListModelView(), festival: FestivalModelView())
    }
}
