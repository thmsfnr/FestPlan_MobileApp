//
//  UserSlotService.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import Foundation
import SwiftUI

struct UserSlot: Codable, Equatable, Hashable {
    
    let UserIdUser: Int
    let SlotIdSlot: Int
    let zone: Int
    let User: User?
    let Slot: Slot?
    let Zone: Zone?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(UserIdUser)
        hasher.combine(SlotIdSlot)
        hasher.combine(zone)
        hasher.combine(User)
        hasher.combine(Slot)
        hasher.combine(Zone)
    }
}

class UserSlotService {
    
    let apiUrl = ApiConfig().url + "/userSlot/"
    
    func getUserSlot(SlotIdSlot: Int? = nil, UserIdUser: Int? = nil, zone: Int? = nil, completion: @escaping ([UserSlot]) -> Void) {

        var parameters: [String: Any] = [:]
        if let newSlot = SlotIdSlot {
            parameters["slot"] = newSlot
        }
        if let newUser = UserIdUser {
            parameters["user"] = newUser
        }
        if let newZone = zone {
            parameters["zone"] = newZone
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
                    let userSlots = try decoder.decode([UserSlot].self, from: data)
                    completion(userSlots)
                } catch {
                    completion([])
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }.resume()
        } catch {
            return
        }
    }
    
    func updateUserSlot(SlotIdSlot: Int, UserIdUser: Int, zone: Int? = nil, completion: @escaping (Bool, Error?) -> ()) {
        
        var parameters: [String: Any] = [:]
        parameters["slot"] = SlotIdSlot
        parameters["user"] = UserIdUser
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            guard let urlString = "\(apiUrl)\(String(data: jsonData, encoding: .utf8)!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string: urlString) else {
                return
            }
            var request = URLRequest(url: url)
            
            var updatedUserSlot: [String: Any] = [:]
            if let zone = zone { updatedUserSlot["zone"] = zone }

            do {
                request.httpMethod = "PUT"
                request.httpBody = try JSONSerialization.data(withJSONObject: updatedUserSlot)
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
        catch {
            return
        }
    }
    
    func deleteUserSlot(SlotIdSlot: Int, UserIdUser: Int, completion: @escaping (Bool, Error?) -> ()) {
        
        var parameters: [String: Any] = [:]
        parameters["slot"] = SlotIdSlot
        parameters["user"] = UserIdUser
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            guard let urlString = "\(apiUrl)\(String(data: jsonData, encoding: .utf8)!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let url = URL(string: urlString) else {
                return
            }
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
        catch {
            return
        }
    }
    
    func createUserSlot(SlotIdSlot: Int, UserIdUser: Int, zone: Int? = nil, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: apiUrl)!
        var request = URLRequest(url: url)
        
        var parameters: [String: Any] = [:]
        parameters["slot"] = SlotIdSlot
        parameters["user"] = UserIdUser
        if let newZone = zone {
            parameters["zone"] = newZone
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
