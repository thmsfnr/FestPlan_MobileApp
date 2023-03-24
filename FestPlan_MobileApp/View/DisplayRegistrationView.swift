//
//  DisplayRegistrationView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 18/03/2023.
//

import SwiftUI

struct DisplayRegistrationView: View {
    
    var festival: Int
    
    init(festival: Int) {
        self.festival = festival
    }
    
    var body: some View {
        VStack  {
            Text("\(festival)")
        }
    }
}

struct DisplayRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayRegistrationView(festival: 1)
    }
}
