//
//  AuthHeader.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 14/03/2023.
//

import Foundation

class AuthHeader {
    
    static func authHeader() -> String {
        if let userData = UserDefaults.standard.data(forKey: "user") {
            do {
                let user = try JSONDecoder().decode(Auth.self, from: userData)
                return user.accessToken
            } catch {
                print("Error decoding user data: \(error)")
            }
        } else {
            print("No user data found in UserDefaults")
        }
        return ""
    }
    
}
