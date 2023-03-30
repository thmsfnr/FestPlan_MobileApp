//
//  VolunteerListView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import SwiftUI

struct VolunteerListView: View {
    
    @ObservedObject var viewModel: UserListModelView
    var intent : UserListIntent
    
    init(model : UserListModelView) {
        self.viewModel = model
        self.intent = UserListIntent(userList: model)
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.list, id: \.self){item in
                        VStack(alignment: .leading)
                    {
                        Text("\(item.email)")
                        Text("\(item.name)")
                        Text("\(item.surname)")
                    }
                }
            }
        }.onAppear(perform: {
            intent.load()
        })
    }
}
            
struct VolunteerListView_Previews: PreviewProvider {
    static var previews: some View {
        VolunteerListView(model: UserListModelView())
    }
}
