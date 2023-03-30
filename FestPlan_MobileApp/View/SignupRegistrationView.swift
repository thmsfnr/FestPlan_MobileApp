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
                HStack {
                    Spacer()
                    
                    Text("Inscription à des créneaux")
                        .font(.system(size: 20))
                        .bold()
                    
                    Spacer()
                }
                if viewModel.list.count == 0 {
                    HStack {
                        Spacer()
                        
                        Text("Plus de créneaux disponible")
                            .font(.system(size: 20))
                        
                        Spacer()
                    }
                }
                ForEach(viewModel.list, id: \.self){item in
                    ForEach(item.slots, id: \.self){item2 in
                        HStack{
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Jour: \(item2.nameDay)")
                                Text("Zone: \(item.nameZone)")
                                Text("Début: \(item2.startHour)")
                                Text("Fin: \(item2.endHour)")
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                intent.signup(slot:item2.idSlot, zone: item.idZone)
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 30))
                            }
                            
                            Spacer()
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
