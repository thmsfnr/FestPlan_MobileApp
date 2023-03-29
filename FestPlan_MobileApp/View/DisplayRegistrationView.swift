//
//  DisplayRegistrationView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 18/03/2023.
//

import SwiftUI

struct DisplayRegistrationView: View {
    
    @ObservedObject var viewModel: UserSlotListModelView
    var festival: Int
    var intent: UserSlotListIntent
    
    init(model: UserSlotListModelView, festival: Int) {
        self.festival = festival
        self.viewModel = model
        self.intent = UserSlotListIntent(userSlotList: model)
    }
    
    var body: some View {
        VStack  {
            List {
                ForEach(viewModel.list, id: \.self){item in
                    VStack{
                        Text("\(item.nameZone)")
                        Text("\(item.startHour)")
                        Text("\(item.endHour)")
                        Text("\(item.nameDay)")
                    }
                }.onDelete { indexSet in
                    let item = indexSet.map { viewModel.list[$0] }
                    intent.remove(uId: item[0].UserIdUser, sId: item[0].SlotIdSlot)
                }
                
            }
        }
        .onAppear(perform: {
            intent.loadUser()
        })
    }
}

struct DisplayRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayRegistrationView(model: UserSlotListModelView(), festival: FestivalModelView().idFestival)
    }
}
