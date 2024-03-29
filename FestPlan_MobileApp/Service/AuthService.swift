//
//  AuthService.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 18/03/2023.
//

import SwiftUI

struct Auth: Codable {
    var id: Int
    var name: String
    var surname: String
    var email: String
    var accessToken: String
}

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
                if let token = json?["accessToken"] as? String {
                    let user = Auth(id: json?["id"] as? Int ?? 0, name: json?["name"] as? String ?? "", surname: json?["surname"] as? String ?? "", email: json?["email"] as? String ?? "", accessToken: token)
                    let encoder = JSONEncoder()
                    if let data = try? encoder.encode(user) {
                        UserDefaults.standard.set(data, forKey: "user")
                        UserDefaults.standard.synchronize()
                        completion(true, nil)
                    } else {
                        completion(false, nil)
                    }
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
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(false, nil)
                return
            }
            if httpResponse.statusCode == 200 {
                completion(true, nil)
            } else {
                completion(false, nil)
            }
        }.resume()
    }
    
}

