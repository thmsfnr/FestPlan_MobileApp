//
//  DisplayRegistrationView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 18/03/2023.
//

import SwiftUI

struct DisplayRegistrationView: View {
    
    var festival: Int
    
    @ObservedObject var viewModel: UserSlotListModelView
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
                        Text("\(item.UserIdUser)")
                        Button("Button title") {
                            print("Button tapped!")
                        }
                        Text("\(item.UserIdUser)")
                    }
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
        DisplayRegistrationView(model: UserSlotListModelView(), festival: 1)
    }
}
