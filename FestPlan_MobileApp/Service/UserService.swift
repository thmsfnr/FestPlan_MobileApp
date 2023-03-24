//
//  UserService.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import Foundation
import SwiftUI

struct User: Codable, Equatable, Hashable {
    let idUser: Int
    let name: String
    let surname: String
    let email: String
    let password: String
    let role: Int
    let Role: Role
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idUser)
        hasher.combine(name)
        hasher.combine(surname)
        hasher.combine(email)
        hasher.combine(password)
        hasher.combine(role)
        hasher.combine(Role)
    }
}

class UserService {
    
    let apiUrl = ApiConfig().url + "/user/"
    
    func getUser(idUser: Int? = nil, name: String? = nil, surname: String? = nil, email: String? = nil, role: Int? = nil, completion: @escaping ([User]) -> Void) {

        var parameters: [String: Any] = [:]
        if let id = idUser {
            parameters["idUser"] = id
        }
        if let newName = name {
            parameters["name"] = newName
        }
        if let newSurname = surname {
            parameters["surname"] = newSurname
        }
        if let newEmail = email {
            parameters["email"] = newEmail
        }
        if let newRole = role {
            parameters["role"] = newRole
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            guard let urlString = "\(apiUrl)\(String(data: jsonData, encoding: .utf8)!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string: urlString) else {
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("\(AuthHeader.authHeader())", forHTTPHeaderField: "x-access-token")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let users = try decoder.decode([User].self, from: data)
                    completion(users)
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }.resume()
        } catch {
            return
        }
    }
    
    func updateUser(idUser: Int, name: String? = nil, surname: String? = nil, email: String? = nil, role: Int? = nil, password: String? = nil, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: "\(apiUrl)\(idUser)")!
        var request = URLRequest(url: url)
        
        var updatedUser: [String: Any] = [:]
        if let name = name { updatedUser["name"] = name }
        if let surname = surname { updatedUser["surname"] = surname }
        if let email = email { updatedUser["email"] = email }
        if let role = role { updatedUser["role"] = role }
        if let password = password { updatedUser["password"] = password }

        do {
            request.httpMethod = "PUT"
            request.httpBody = try JSONSerialization.data(withJSONObject: updatedUser)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("\(AuthHeader.authHeader())", forHTTPHeaderField: "x-access-token")

            URLSession.shared.dataTask(with: request) { (data, response, error) in

                if let error = error {
                    completion(false, error)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    completion(true, nil)
                } else {
                    completion(false, NSError(domain: "APIError", code: -1, userInfo: nil))
                }
            }.resume()
        } catch {
            completion(false, error)
            return
        }
    }
    
    func deleteUser(idUser: Int, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: "\(apiUrl)\(idUser)")!
        var request = URLRequest(url: url)
            
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(AuthHeader.authHeader())", forHTTPHeaderField: "x-access-token")
            
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(false, error)
                return
            }
                
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(true, nil)
            } else {
                completion(false, NSError(domain: "APIError", code: -1, userInfo: nil))
            }
        }.resume()
    }
    
    func createUser(name: String? = nil, surname: String? = nil, email: String, role: Int? = nil, password: String, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: apiUrl)!
        var request = URLRequest(url: url)
        
        var parameters: [String: Any] = [:]
        parameters["email"] = email
        parameters["password"] = password
        if let newName = name{
            parameters["name"] = newName
        }
        if let newSurname = surname {
            parameters["surname"] = newSurname
        }
        if let newRole = role {
            parameters["role"] = newRole
        }
        
        request.httpMethod = "POST"
        request.addValue("\(AuthHeader.authHeader())", forHTTPHeaderField: "x-access-token")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
