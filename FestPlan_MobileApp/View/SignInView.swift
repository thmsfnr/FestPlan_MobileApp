//
//  SignInView.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 02/03/2023.
//

import SwiftUI

struct SignInView: View {

    // MARK: - Properties

    @ObservedObject var viewModel = SignInViewModel()
    @State private var isSignUpActive = false

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
                        .disabled(viewModel.isSigningIn)
                        
                        if viewModel.isSigningIn {
                            ProgressView()
                                .progressViewStyle(.circular)
                        } else {
                            NavigationLink(destination: HomeBoardView().navigationBarBackButtonHidden(true)) {
                                Text("Sign In")
                            }
                            .onTapGesture {
                                //viewModel.signIn()
                                UserDefaults.standard.set("test", forKey: "user")
                            }
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: 400.0)
                    
                    Spacer()
                }
                .alert(isPresented: $viewModel.hasError) {
                    Alert(
                        title: Text("Sign In Failed"),
                        message: Text("The email/password combination is invalid.")
                    )
                }
                    
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
        SignInView(viewModel: SignInViewModel())
    }
}
