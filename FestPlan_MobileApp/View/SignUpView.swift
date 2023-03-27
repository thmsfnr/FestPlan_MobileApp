//
//  SignUpView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 18/03/2023.
//

import SwiftUI

struct SignUpView: View {

    @ObservedObject var viewModel: UserModelView
    var intent: UserIntent
    
    init(model: UserModelView) {
        self.viewModel = model
        self.intent = UserIntent(user: model)
    }

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    
                    VStack {
                        Image("logo")
                               .resizable()
                               .scaledToFit()
                        
                        VStack(alignment: .center) {
                            Text("Email")
                            TextField("Email", text: $viewModel.email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .disableAutocorrection(true)
                            
                            Text("Mot de passe")
                            SecureField("Mot de passe", text: $viewModel.password)
                            
                            Text("Nom")
                            TextField("Nom", text: $viewModel.name)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .disableAutocorrection(true)
                            
                            Text("Prénom")
                            TextField("Prénom", text: $viewModel.surname)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .disableAutocorrection(true)
                        }
                        .textFieldStyle(.roundedBorder)

                        Button(action: {
                            intent.signup(email: viewModel.email, password: viewModel.password, name: viewModel.name, surname: viewModel.surname)
                        }) {
                            Text("Valider")
                                .foregroundColor(.white)
                                .padding(10)
                                .frame(width: 138)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        .padding(.top, 20)
                        
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: 400.0)
                    
                    Spacer()
                }
                .background(
                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true),isActive: $viewModel.isCreated) {
                        EmptyView()
                    }
                    .hidden()
                )
            }
            .navigationBarTitle("Inscription")
            .navigationBarTitleDisplayMode(.inline)
            .background(
                Color(red: 0.9, green: 0.9, blue: 0.9)
            )
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(model: UserModelView())
    }
}
