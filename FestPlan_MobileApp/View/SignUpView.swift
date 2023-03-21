//
//  SignUpView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 18/03/2023.
//

import SwiftUI

struct SignUpView: View {

    @ObservedObject var viewModel: UserViewModel
    var intent: UserIntent
    
    init(model: UserViewModel) {
        self.viewModel = model
        self.intent = UserIntent(user: model)
    }

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    
                    VStack {
                        VStack(alignment: .leading) {
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

                        Button("Valider") {
                            intent.signup(email: viewModel.email, password: viewModel.password, name: viewModel.name, surname: viewModel.surname)
                        }
                        
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
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(model: UserViewModel())
    }
}
