//
//  SlotCreationView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import SwiftUI

struct SlotCreationView: View {
    
    @State var content: SlotModelView
    var intent: SlotListIntent
    var festival: FestivalModelView
    @State private var showNewView = false
    
    init(content: SlotModelView, intent: SlotListIntent, festival: FestivalModelView) {
        self.content = content
        self.intent = intent
        self.festival = festival
    }

    var body: some View {
            VStack {
                
            }
        
    }
}

struct SlotCreationView_Previews: PreviewProvider {
    static var previews: some View {
        SlotCreationView(content: SlotModelView(), intent: SlotListIntent(slotList: SlotListModelView()), festival: FestivalModelView())
    }
}
