//
//  ConsultActivityView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 14/03/2023.
//

import SwiftUI

struct Activity: Codable, Hashable {
    let idActivity: Int?
    let nameActivity: String?
    let type: Int?
}

struct ConsultActivityView: View {
    @State var activities: [ActivityAPI] = []
    
    var body: some View {
        VStack {
            Text("test2")
            ForEach(activities, id: \.self) { activity in
                Text(activity.nameActivity ?? "test")
            }
        }
        .padding()
        .onAppear(perform: {
            ActivityService().getActivity() { result in
                DispatchQueue.main.async {
                    self.activities = result
                }
            }
        })
    }
}

struct ConsultActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ConsultActivityView()
    }
}
