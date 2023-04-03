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
    @State var isActive = false
    @Environment(\.presentationMode) var presentationMode
    
    init(model: ZoneListModelView, festival: FestivalModelView) {
        self.viewModel = model
        self.intent = ZoneListIntent(zoneList: model)
        self.festival = festival
    }

    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink(destination: HomeBoardView(model: FestivalModelView()).navigationBarBackButtonHidden(true)) {
                    Text("Accueil")
                }
                .hidden()
                .navigationBarItems(leading:
                                        Button("< Back") {
                    presentationMode.wrappedValue.dismiss()
                },
                                    trailing: NavigationLink(destination: AdminBoardView(model: festival).navigationBarBackButtonHidden(true), isActive: $isActive) {
                    EmptyView()
                })
                VStack{
                    NavigationLink(destination: ZoneCreationView(content: ZoneModelView(), intent: intent, festival: festival)) {
                        Image(systemName: "plus")
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                    }
                }
                
                List {
                    ForEach(viewModel.list, id: \.self){item in
                        NavigationLink(destination: ZoneDetailView(content: item, intent: intent, festival: festival)){
                            Spacer()
                            VStack(alignment: .leading){
                                Text("Zone: " + "\(item.nameZone)")
                                Text("Volontaires requis: " + "\(item.maxVolunteers)")
                            }
                        }
                    }
                    .onDelete { indexSet in
                        let id = indexSet.map { viewModel.list[$0].idZone }
                        intent.remove(zone: id[0])
                    }
                }
            }
        }.navigationBarTitle("Zone - Gestion")
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
