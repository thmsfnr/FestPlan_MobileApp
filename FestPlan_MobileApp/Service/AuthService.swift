//
//  AuthService.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 18/03/2023.
//

import SwiftUI

class AuthService {

    let apiUrl = ApiConfig().url + "/auth/"

    func login(email: String, password: String, completion: @escaping (Bool, Error?) -> ()) {
        // Set up the URL request
        let endpoint = apiUrl + "signin"
        guard let url = URL(string: endpoint) else {
            completion(false, nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set the request parameters
        let params = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        // Set the request headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Make the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error)
                return
            }
            guard let data = data else {
                completion(false, nil)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let token = json?["token"] as? String {
                    // Save the token to user defaults or keychain
                    UserDefaults.standard.set(token, forKey: "user")
                    completion(true, nil)
                } else {
                    completion(false, nil)
                }
            } catch {
                completion(false, error)
            }
        }.resume()
    }
    
    func signup(email: String, password: String, name: String, surname: String, completion: @escaping (Bool, Error?) -> ()) {
        // Set up the URL request
        let endpoint = apiUrl + "signup"
        guard let url = URL(string: endpoint) else {
            completion(false, nil)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set the request parameters
        let params = ["email": email, "password": password, "name": name, "surname": surname]
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        // Set the request headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Make the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error)
                return
            }
            guard let data = data else {
                completion(false, nil)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let _ = json?["token"] as? String {
                    completion(true, nil)
                } else {
                    completion(false, nil)
                }
            } catch {
                completion(false, error)
            }
        }.resume()
    }
}

