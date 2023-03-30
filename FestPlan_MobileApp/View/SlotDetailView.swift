//
//  SlotDetailView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import SwiftUI

struct SlotDetailView: View {
    
    @State var content: SlotModelView
    var intent: SlotListIntent
    var festival: FestivalModelView
    @ObservedObject var listUserSub: UserListModelView
    @ObservedObject var listUserFree: UserListModelView
    var userSubIntent: UserListIntent
    var userFreeIntent: UserListIntent
    var userSlotIntent: UserSlotIntent
    @State var userSlot: UserSlotModelView
    @State private var showNewView = false
    @State private var selectedUser = 0
    
    init(content: SlotModelView, intent: SlotListIntent, festival: FestivalModelView, listUserSub: UserListModelView, listUserFree: UserListModelView, userSlot: UserSlotModelView) {
        self.content = content
        self.intent = intent
        self.festival = festival
        self.listUserSub = listUserSub
        self.listUserFree = listUserFree
        self.userSlot = userSlot
        self.userSubIntent = UserListIntent(userList: listUserSub)
        self.userFreeIntent = UserListIntent(userList: listUserFree)
        self.userSlotIntent = UserSlotIntent(userSlot: userSlot)
    }

    var body: some View {
        NavigationView {
            VStack {
                /*
                NavigationLink(destination: SlotManagementView(model: SlotListModelView(), festival: festival).navigationBarBackButtonHidden(true)) {
                    Text("Retour")
                }
                 */
                Text("Nom du jour \(content.nameDay)")
                Text("Heure de départ \(content.startHour)")
                Text("Heure de fin \(content.endHour)")
                Text("Nom de la zone \(content.nameZone)")
                
                if listUserFree.list.count != 0 {
                    Picker(selection: $selectedUser, label: Text("Select a user")) {
                        ForEach(listUserFree.list, id: \.self) { index in
                            Text(index.email).tag(index.idUser)
                        }
                    }
                    .onChange(of: selectedUser) { value in
                        userFreeIntent.add(user: selectedUser, slot: content.idSlot, zone: content.zone)
                        sleep(1)
                        userSubIntent.loadSlot(slot: content.idSlot)
                        userFreeIntent.loadFree(slot: content.idSlot)
                    }
                }
                
                List {
                    ForEach(listUserSub.list, id: \.self){item in
                            VStack{
                                Text("\(item.email)")
                                Text("\(item.name)")
                                Text("\(item.surname)")
                            }
                    }
                    .onDelete { indexSet in
                        let id = indexSet.map { listUserSub.list[$0].idUser }
                        userSubIntent.remove(user: id[0], slot: content.idSlot)
                        sleep(1)
                        userSubIntent.loadSlot(slot: content.idSlot)
                        userFreeIntent.loadFree(slot: content.idSlot)
                    }
                }
            }
        }//.navigationBarBackButtonHidden(true)
        .navigationBarTitle("Créanaux - Détail")
            .onAppear(perform: {
                userSubIntent.loadSlot(slot: content.idSlot)
                userFreeIntent.loadFree(slot: content.idSlot)
                userSlotIntent.loadZone(zone: content.zone)
            })
        
    }
}

struct SlotDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SlotDetailView(content: SlotModelView(), intent: SlotListIntent(slotList: SlotListModelView()), festival: FestivalModelView(), listUserSub: UserListModelView(), listUserFree: UserListModelView(), userSlot: UserSlotModelView())
    }
}
