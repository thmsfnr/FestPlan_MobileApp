//
//  DayDetailView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import SwiftUI

struct DayDetailView: View {
    
    @State var content: DayModelView
    var intent: DayListIntent
    
    init(content: DayModelView, intent: DayListIntent) {
        self.content = content
        self.intent = intent
    }

    var body: some View {
        VStack {
            
        }
    }
}

struct DayDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DayDetailView(content: DayModelView(), intent: DayListIntent(dayList: DayListModelView()))
    }
}
