//
//  AuthHeader.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 14/03/2023.
//

import Foundation

class AuthHeader {
    
    func authHeader() -> [String: String] {
        let userDefaults = UserDefaults.standard
        let token = UserDefaults.standard.string(forKey: "accessToken")
        if let accessToken = token {
            return ["x-access-token": accessToken]
        }
        return ["x-access-token": ""]
    }
    
}
