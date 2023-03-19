//
//  SignInView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 02/03/2023.
//

import SwiftUI

struct SignInView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: SignInViewModel
    var intent: SignInIntent
    
    init(model: SignInViewModel) {
        self.viewModel = model
        self.intent = SignInIntent(signIn: model)
    }

    // MARK: - View

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
                            Text("Password")
                            SecureField("Password", text: $viewModel.password)
                        }
                        .textFieldStyle(.roundedBorder)

                            Button("Sign In") {
                                intent.login(email: viewModel.email, password: viewModel.password)
                            }
                        
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: 400.0)
                    
                    Spacer()
                }
                .background(
                                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true),
                                               isActive: $viewModel.isSignIn) {
                                    EmptyView()
                                }
                                .hidden()
                            )
                    
                NavigationLink(destination: SignUpView()) {
                    Text("No account")
                }
            }
            .navigationBarTitle("Login")

        }
        
    }

}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(model: SignInViewModel())
    }
}
