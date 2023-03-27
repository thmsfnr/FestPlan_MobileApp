//
//  SignInView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 02/03/2023.
//

import SwiftUI

struct SignInView: View {
    
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
                            }
                            .textFieldStyle(.roundedBorder)
                            
                            Button(action: {
                                intent.login(email: viewModel.email, password: viewModel.password)
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
                        NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true),isActive: $viewModel.isSignIn) {
                            EmptyView()
                        }
                            .hidden()
                    )
                    
                    NavigationLink(destination: SignUpView(model: UserModelView())) {
                        Text("Pas de compte ?")
                            .foregroundColor(.white)
                            .padding(10)
                            .frame(width: 170)
                            .background(Color.gray)
                            .cornerRadius(10)
                    }
                }
                .navigationBarTitle("Connexion")
                .navigationBarTitleDisplayMode(.inline)
                .background(
                    Color(red: 0.9, green: 0.9, blue: 0.9)
                )
            }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(model: UserModelView())
    }
}
