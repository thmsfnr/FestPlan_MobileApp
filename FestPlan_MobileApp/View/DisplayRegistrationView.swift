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
                HStack {
                    Spacer()
                    
                    Text("Mes inscriptions")
                        .font(.system(size: 20))
                        .bold()
                    
                    Spacer()
                }
                if viewModel.list.count == 0 {
                    HStack {
                        Spacer()
                        
                        Text("Aucune inscription")
                            .font(.system(size: 20))
                        
                        Spacer()
                    }
                }
                ForEach(viewModel.list, id: \.self){item in
                    HStack{
                        Spacer()
                        
                        VStack(alignment: .center) {
                            Text("Jour: \(item.nameDay)")
                            Text("Zone: \(item.nameZone)")
                            Text("Début: \(item.startHour)")
                            Text("Fin:\(item.endHour)")
                        }
                        
                        Spacer()
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
