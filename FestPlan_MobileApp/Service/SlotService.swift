//
//  SlotService.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import Foundation
import SwiftUI

struct Slot: Codable, Equatable, Hashable {
    let idSlot: Int
    let startHour: String
    let endHour: String
    let day: Int
    let zone: Int
    let Zone: Zone?
    let Day: Day?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idSlot)
        hasher.combine(startHour)
        hasher.combine(endHour)
        hasher.combine(day)
        hasher.combine(zone)
        hasher.combine(Zone)
        hasher.combine(Day)
        
    }
}

class SlotService {
    
    let apiUrl = ApiConfig().url + "/slot/"
    
    func getSlot(idSlot: Int? = nil, startHour: String? = nil, endHour: String? = nil, day: Int? = nil, zone: Int? = nil, completion: @escaping ([Slot]) -> Void) {

        var parameters: [String: Any] = [:]
        if let id = idSlot {
            parameters["idSlot"] = id
        }
        if let newStartHour = startHour {
            parameters["startHour"] = newStartHour
        }
        if let newEndHour = endHour {
            parameters["endHour"] = newEndHour
        }
        if let newDay = day {
            parameters["day"] = newDay
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
                    let slots = try decoder.decode([Slot].self, from: data)
                    completion(slots)
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }.resume()
        } catch {
            return
        }
    }
    
    func updateSlot(idSlot: Int, startHour: String? = nil, endHour: String? = nil, day: Int? = nil, zone: Int? = nil, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: "\(apiUrl)\(idSlot)")!
        var request = URLRequest(url: url)
        
        var updatedSlot: [String: Any] = [:]
        if let startHour = startHour { updatedSlot["startHour"] = startHour }
        if let endHour = endHour { updatedSlot["endHour"] = endHour }
        if let day = day { updatedSlot["day"] = day }
        if let zone = zone { updatedSlot["zone"] = zone }

        do {
            request.httpMethod = "PUT"
            request.httpBody = try JSONSerialization.data(withJSONObject: updatedSlot)
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
    
    func deleteSlot(idSlot: Int, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: "\(apiUrl)\(idSlot)")!
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
    
    func createSlot(startHour: String, endHour: String, day: Int? = nil, zone: Int? = nil, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: apiUrl)!
        var request = URLRequest(url: url)
        
        var parameters: [String: Any] = [:]
        parameters["startHour"] = startHour
        parameters["endHour"] = endHour
        if let newDay = day {
            parameters["day"] = newDay
        }
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
