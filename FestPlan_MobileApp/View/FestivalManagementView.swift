//
//  FestivalManagementView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import SwiftUI

struct FestivalManagementView: View {
    
    @ObservedObject var viewModel: FestivalListModelView
    var festivalPrime: FestivalModelView
    var intent: FestivalListIntent
    
    init(model: FestivalListModelView, festival: FestivalModelView) {
        self.viewModel = model
        self.intent = FestivalListIntent(festivalList: model)
        self.festivalPrime = festival
    }

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: AdminBoardView(model: festivalPrime).navigationBarBackButtonHidden(true)) {
                    Text("Retour")
                }
                NavigationLink(destination: FestivalCreationView(content: FestivalModelView(), intent: intent, festival: festivalPrime)) {
                    Text("Ajouter Festival")
                }
                List {
                    ForEach(viewModel.list, id: \.self){item in
                        NavigationLink(destination: FestivalDetailView(content: item, intent: intent, festival: festivalPrime)){
                            VStack{
                                Text(item.nameFestival + " \(item.year)")
                            }
                        }
                    }
                    .onDelete { indexSet in
                        let id = indexSet.map { viewModel.list[$0].idFestival }
                        intent.remove(festival: id[0])
                    }
                }
            }
        }
        .onAppear(perform: {
            intent.load(festival: festivalPrime.idFestival)
        })
    }
}

struct FestivalManagementView_Previews: PreviewProvider {
    static var previews: some View {
        FestivalManagementView(model: FestivalListModelView(), festival: FestivalModelView())
    }
}
