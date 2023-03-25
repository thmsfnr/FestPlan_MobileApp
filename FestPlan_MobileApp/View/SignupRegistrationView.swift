//
//  SignupRegistrationView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 21/03/2023.
//

import SwiftUI

struct SignupRegistrationView: View {
    
    var festival: Int
    
    @ObservedObject var viewModel: ZoneSlotListModelView
    var intent: ZoneSlotListIntent
    
    init(model: ZoneSlotListModelView, festival: Int) {
        self.viewModel = model
        self.intent = ZoneSlotListIntent(zoneSlotList: model)
        self.festival = festival
    }
    
    var body: some View {
        VStack  {
            List {
                ForEach(viewModel.list, id: \.self){item in
                    ForEach(item.slots, id: \.self){item2 in
                        VStack{
                            Text("\(item.nameZone)")
                            Text("\(item2.startHour)")
                            Text("\(item2.endHour)")
                            Text("\(item2.nameDay)")
                            Button("Add"){
                                intent.signup(slot:item2.idSlot, zone: item.idZone)
                            }
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            intent.loadFestival(festival: festival)
        })
    }
}

struct SignupRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        SignupRegistrationView(model: ZoneSlotListModelView(), festival: 1)
    }
}
