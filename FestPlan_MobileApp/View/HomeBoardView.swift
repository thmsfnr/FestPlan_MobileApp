//
//  HomeBoardView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 18/03/2023.
//

import SwiftUI

struct HomeBoardView: View {
    
    @ObservedObject var viewModel: FestivalModelView
    var intent: FestivalIntent
    
    init(model: FestivalModelView) {
        self.viewModel = model
        self.intent = FestivalIntent(festival: model)
    }
    
    @State var shouldLogout = false
    @State var isAdmin = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    
                    VStack {
                        Spacer()
                        
                        NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), isActive: $shouldLogout) {
                            EmptyView()
                        }
                        .hidden()
                        .navigationBarItems(leading:
                                                Button(action: {
                            UserDefaults.standard.set(nil, forKey: "user")
                            shouldLogout = true
                        }) {
                            Image(systemName: "person.crop.circle.fill.badge.xmark")
                                .foregroundColor(.red)
                                .font(.system(size: 30))
                        }
                        )
                        if viewModel.isOpen == true {
                            Text(viewModel.nameFestival + " \(viewModel.year)")
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(10)
                            
                            Spacer()

                            NavigationLink(destination: DisplayRegistrationView(model: UserSlotListModelView(), festival: viewModel.idFestival)) {
                                Text("Mes inscriptions")
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .frame(width: 200)
                                    .background(Color.black)
                                    .cornerRadius(10)
                            }
                            NavigationLink(destination: SignupRegistrationView(model: ZoneSlotListModelView(), festival: viewModel.idFestival)) {
                                Text("M'inscrire")
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .frame(width: 200)
                                    .background(Color.black)
                                    .cornerRadius(10)
                            }
                            .padding(.top, 20)
                        } else {
                            Text("Pas de festival")
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(10)
                            
                            Spacer()
                        }
                        if isAdmin == true {
                            NavigationLink(destination: AdminBoardView(model: viewModel).navigationBarBackButtonHidden(true)) {
                                Text("Admin")
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .frame(width: 200)
                                    .background(Color.black)
                                    .cornerRadius(10)
                            }
                            .padding(.top, 20)
                        }
                        
                        Spacer()
                    }
                    Spacer()
                }
            }
            .navigationBarTitle("Accueil")
            .onAppear(perform: {
                intent.loadOpen()
                TestService().isAdmin() { success, error in
                    if !success {
                        return
                    }
                    DispatchQueue.main.async {
                        isAdmin = true
                    }
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .background(
                Color(red: 0.9, green: 0.9, blue: 0.9)
            )
        }
    }
}

struct HomeBoardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBoardView(model: FestivalModelView())
    }
}
