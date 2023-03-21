//
//  AuthHeader.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 14/03/2023.
//

import Foundation

class AuthHeader {
    
    func authHeader() -> String {
        if let userData = UserDefaults.standard.data(forKey: "user") {
            do {
                let user = try JSONDecoder().decode(User.self, from: userData)
                return user.accessToken
                // Now you can use the `accessToken` variable in your `getType` function or any other function that requires authentication.
            } catch {
                print("Error decoding user data: \(error)")
            }
        } else {
            print("No user data found in UserDefaults")
        }
        return ""
    }
}
