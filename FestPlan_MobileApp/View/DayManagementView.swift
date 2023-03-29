//
//  DayManagementView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import SwiftUI

struct DayManagementView: View {
    
    @ObservedObject var viewModel: DayListModelView
    var festival: FestivalModelView
    var intent: DayListIntent
    @State var isActive = false
    @Environment(\.presentationMode) var presentationMode
    
    init(model: DayListModelView, festival: FestivalModelView) {
        self.viewModel = model
        self.intent = DayListIntent(dayList: model)
        self.festival = festival
    }

    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink(destination: HomeBoardView(model: FestivalModelView()).navigationBarBackButtonHidden(true)) {
                    Text("Accueil")
                }
                .hidden()
                .navigationBarItems(leading:
                                        Button("< Back") {
                    presentationMode.wrappedValue.dismiss()
                },
                                    trailing: NavigationLink(destination: AdminBoardView(model: festival).navigationBarBackButtonHidden(true), isActive: $isActive) {
                    EmptyView()
                })
                
                NavigationLink(destination: DayCreationView(content: DayModelView(), intent: intent, festival: festival)) {
                    Text("Ajouter jour")
                }
                List {
                    ForEach(viewModel.list, id: \.self){item in
                        NavigationLink(destination: DayDetailView(content: item, intent: intent, festival: festival)){
                            VStack{
                                Text("\(item.nameDay)")
                                Text("\(item.startHour)")
                                Text("\(item.endHour)")
                            }
                        }
                    }
                    .onDelete { indexSet in
                        let id = indexSet.map { viewModel.list[$0].idDay }
                        intent.remove(day: id[0])
                    }
                }
            }
        }//.navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            intent.load(festival: festival.idFestival)
        })
    }
}

struct DayManagementView_Previews: PreviewProvider {
    static var previews: some View {
        DayManagementView(model: DayListModelView(), festival: FestivalModelView())
    }
}
































