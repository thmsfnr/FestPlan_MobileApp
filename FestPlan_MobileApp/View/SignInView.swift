//
//  SignInView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 02/03/2023.
//

import SwiftUI

struct SignInView: View {

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
                        }
                        .textFieldStyle(.roundedBorder)

                        Button("Valider") {
                            intent.login(email: viewModel.email, password: viewModel.password)
                        }
                        
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
                    
                NavigationLink(destination: SignUpView(model: UserViewModel())) {
                    Text("Pas de compte ?")
                }
            }
            .navigationBarTitle("Connexion")
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(model: UserViewModel())
    }
}
