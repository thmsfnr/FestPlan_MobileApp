//
//  ZoneService.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import Foundation
import SwiftUI

struct Zone: Codable, Equatable, Hashable {
    let idZone: Int
    let nameZone: String
    let maxVolunteers: Int
    let festival: Int
    let Festival: Festival
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idZone)
        hasher.combine(nameZone)
        hasher.combine(maxVolunteers)
        hasher.combine(festival)
        hasher.combine(Festival)
    }
}

class ZoneService {
    
    let apiUrl = ApiConfig().url + "/zone/"
    
    func getZone(idZone: Int? = nil, nameZone: String? = nil, maxVolunteers: Int? = nil, festival: Int? = nil, completion: @escaping ([Zone]) -> Void) {

        var parameters: [String: Any] = [:]
        if let id = idZone {
            parameters["idZone"] = id
        }
        if let name = nameZone {
            parameters["nameZone"] = name
        }
        if let newMaxVolunteers = maxVolunteers {
            parameters["maxVolunteers"] = newMaxVolunteers
        }
        if let newFestival = festival {
            parameters["festival"] = newFestival
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
                    let zones = try decoder.decode([Zone].self, from: data)
                    completion(zones)
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }.resume()
        } catch {
            return
        }
    }
    
    func updateZone(idZone: Int, nameZone: String? = nil, maxVolunteers: Int? = nil, festival: Int? = nil, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: "\(apiUrl)\(idZone)")!
        var request = URLRequest(url: url)
        
        var updatedZone: [String: Any] = [:]
        if let name = nameZone { updatedZone["nameZone"] = name }
        if let maxVolunteers = maxVolunteers { updatedZone["maxVolunteers"] = maxVolunteers }
        if let festival = festival { updatedZone["festival"] = festival }

        do {
            request.httpMethod = "PUT"
            request.httpBody = try JSONSerialization.data(withJSONObject: updatedZone)
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
    
    func deleteZone(idZone: Int, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: "\(apiUrl)\(idZone)")!
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
    
    func createZone(nameZone: String, maxVolunteers: Int? = nil, festival: Int? = nil, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: apiUrl)!
        var request = URLRequest(url: url)
        
        var parameters: [String: Any] = [:]
        parameters["nameZone"] = nameZone
        if let newMaxVolunteers = maxVolunteers {
            parameters["maxVolunteers"] = newMaxVolunteers
        }
        if let newFestival = festival {
            parameters["festival"] = newFestival
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
