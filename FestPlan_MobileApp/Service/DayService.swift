//
//  DayService.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import Foundation
import SwiftUI

struct Day: Codable, Equatable, Hashable {
    let idDay: Int
    let nameDay: String
    let startHour: String
    let endHour: String
    let festival: Int
    let Festival: Festival?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idDay)
        hasher.combine(nameDay)
        hasher.combine(startHour)
        hasher.combine(endHour)
        hasher.combine(festival)
        hasher.combine(Festival)
    }
}

class DayService {
    
    let apiUrl = ApiConfig().url + "/day/"
    
    func getDay(idDay: Int? = nil, nameDay: String? = nil, startHour: String? = nil, endHour: String? = nil, festival: Int? = nil, completion: @escaping ([Day]) -> Void) {

        var parameters: [String: Any] = [:]
        if let id = idDay {
            parameters["idDay"] = id
        }
        if let name = nameDay {
            parameters["nameDay"] = name
        }
        if let newStartHour = startHour {
            parameters["startHour"] = newStartHour
        }
        if let newEndHour = endHour {
            parameters["endHour"] = newEndHour
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
                    let days = try decoder.decode([Day].self, from: data)
                    completion(days)
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }.resume()
        } catch {
            return
        }
    }
    
    func updateDay(idDay: Int, nameDay: String? = nil, startHour: String? = nil, endHour: String? = nil, festival: Int? = nil, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: "\(apiUrl)\(idDay)")!
        var request = URLRequest(url: url)
        
        var updatedDay: [String: Any] = [:]
        if let name = nameDay { updatedDay["nameDay"] = name }
        if let startHour = startHour { updatedDay["startHour"] = startHour }
        if let endHour = endHour { updatedDay["endHour"] = endHour }
        if let festival = festival { updatedDay["festival"] = festival }

        do {
            request.httpMethod = "PUT"
            request.httpBody = try JSONSerialization.data(withJSONObject: updatedDay)
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
    
    func deleteDay(idDay: Int, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: "\(apiUrl)\(idDay)")!
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
    
    func createDay(nameDay: String, startHour: String? = nil, endHour: String? = nil, festival: Int? = nil, completion: @escaping (Bool, Error?) -> ()) {
        
        let url = URL(string: apiUrl)!
        var request = URLRequest(url: url)
        
        var parameters: [String: Any] = [:]
        parameters["nameDay"] = nameDay
        if let newStartHour = startHour {
            parameters["startHour"] = newStartHour
        }
        if let newEndHour = endHour {
            parameters["endHour"] = newEndHour
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
