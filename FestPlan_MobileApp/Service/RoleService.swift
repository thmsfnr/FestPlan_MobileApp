//
//  RoleService.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import Foundation
import SwiftUI

struct Role: Codable, Equatable, Hashable {
    let idRole: Int
    let nameRole: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idRole)
        hasher.combine(nameRole)
    }
}

class RoleService {
    
    let apiUrl = ApiConfig().url + "/role/"
    
    func getRole(idRole: Int? = nil, nameRole: String? = nil, completion: @escaping ([Role]) -> Void) {

        var parameters: [String: Any] = [:]
        if let id = idRole{
            parameters["idRole"] = id
        }
        if let name = nameRole {
            parameters["nameRole"] = name
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
                    let roles = try decoder.decode([Role].self, from: data)
                    completion(roles)
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }.resume()
        } catch {
            return
        }
    }
    
    func updateRole(idRole: Int, nameRole: String? = nil, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: "\(apiUrl)\(idRole)")!
        var request = URLRequest(url: url)
        
        var updatedRole: [String: Any] = [:]
        if let name = nameRole { updatedRole["nameRole"] = name }

        do {
            request.httpMethod = "PUT"
            request.httpBody = try JSONSerialization.data(withJSONObject: updatedRole)
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
    
    func deleteRole(idRole: Int, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: "\(apiUrl)\(idRole)")!
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
    
    func createRole(nameRole: String, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: apiUrl)!
        var request = URLRequest(url: url)
        
        var parameters: [String: Any] = [:]
        parameters["nameRole"] = nameRole
        
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
