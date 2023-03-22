//
//  FestivalService.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 21/03/2023.
//

import Foundation
import SwiftUI

struct Festival: Codable, Equatable, Hashable {
    let idFestival: Int
    let nameFestival: String
    let year: Int
    let nbDays: Int
    let isOpen: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idFestival)
        hasher.combine(nameFestival)
        hasher.combine(year)
        hasher.combine(nbDays)
        hasher.combine(isOpen)
    }
}

class FestivalService {
    
    let apiUrl = ApiConfig().url + "/festival/"
    
    func getFestival(idFestival: Int? = nil, nameFestival: String? = nil, year: Int? = nil, nbDays: Int? = nil, isOpen: Bool? = nil, completion: @escaping ([Festival]) -> Void) {

        var parameters: [String: Any] = [:]
        if let id = idFestival {
            parameters["idFestival"] = id
        }
        if let name = nameFestival {
            parameters["nameFestival"] = name
        }
        if let newYear = year {
            parameters["year"] = newYear
        }
        if let newNbDays = nbDays {
            parameters["nbDays"] = newNbDays
        }
        if let newIsOpen = isOpen {
            parameters["isOpen"] = newIsOpen
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
                    let festivals = try decoder.decode([Festival].self, from: data)
                    completion(festivals)
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }.resume()
        } catch {
            return
        }
    }
    
    func updateFestival(idFestival: Int, nameFestival: String? = nil, year: Int? = nil, nbDays: Int? = nil, isOpen: Bool? = nil, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: "\(apiUrl)\(idFestival)")!
        var request = URLRequest(url: url)
        
        var updatedFestival: [String: Any] = [:]
        if let name = nameFestival { updatedFestival["nameFestival"] = name }
        if let year = year { updatedFestival["year"] = year }
        if let nbDays = nbDays { updatedFestival["nbDays"] = nbDays }
        if let isOpen = isOpen { updatedFestival["isOpen"] = isOpen }

        do {
            request.httpMethod = "PUT"
            request.httpBody = try JSONSerialization.data(withJSONObject: updatedFestival)
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
    
    func deleteFestival(idFestival: Int, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: "\(apiUrl)\(idFestival)")!
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
    
    func createFestival(nameFestival: String, year: Int? = nil, nbDays: Int? = nil, isOpen: Int? = nil, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: apiUrl)!
        var request = URLRequest(url: url)
        
        var parameters: [String: Any] = [:]
        parameters["nameFestival"] = nameFestival
        if let newYear = year {
            parameters["year"] = newYear
        }
        if let newNbDays = nbDays {
            parameters["nbDays"] = newNbDays
        }
        if let newIsOpen = isOpen {
            parameters["isOpen"] = newIsOpen
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
