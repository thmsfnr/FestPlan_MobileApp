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
    @State var activities: [Activity] = []
    
    var body: some View {
        VStack {
            Text("test2")
            ForEach(activities, id: \.self) { activity in
                Text(activity.nameActivity ?? "test")
            }
        }
        .padding()
        .onAppear(perform: {
            ActivityService().getActivity(idActivity: nil, nameActivity: nil, type: nil) { result in
                switch result {
                case .success(let data):
                    // Decode the response data into an array of Activity objects
                    if let activities = try? JSONDecoder().decode([Activity].self, from: data) {
                        self.activities = activities
                    }
                case .failure(let error):
                    // Handle the error here
                    self.activities = [Activity(idActivity: 1, nameActivity: "hgdf", type: 5)]
                    print("Error: \(error)")
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
