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
    @State var isActive = false
    @Environment(\.presentationMode) var presentationMode
    
    init(model: SlotListModelView, festival: FestivalModelView) {
        self.viewModel = model
        self.intent = SlotListIntent(slotList: model)
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
                
                NavigationLink(destination: SlotCreationView(content: SlotModelView(), intent: intent, festival: festival, listZone: ZoneListModelView(), listDay: DayListModelView())) {
                        Image(systemName: "plus")
                            .foregroundColor(Color.black)
                            .font(.system(size: 20))
                }
                List {
                    ForEach(viewModel.slots, id: \.self){item in
                        NavigationLink(destination: SlotDetailView(content: item, intent: intent, festival: festival, listUserSub: UserListModelView(), listUserFree: UserListModelView(), userSlot: UserSlotModelView())){
                            VStack(alignment: .leading){
                                Text("Jour: \(item.nameDay)")
                                Text("Zone: \(item.nameZone)")
                                Text("Heure début: \(item.startHour)")
                                Text("Heure fin: \(item.endHour)")
                            }
                        }
                    }
                    .onDelete { indexSet in
                        let id = indexSet.map { viewModel.slots[$0].idSlot }
                        intent.remove(slot: id[0])
                    }
                }.navigationBarTitle("Créanaux - Gestion")
            }
        }.navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            intent.load(festival: festival.idFestival)
        })
    }
}
