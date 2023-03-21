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
    let isOpen: Int
    
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
    
    func getFestival(idFestival: Int? = nil, nameFestival: String? = nil, year: Int? = nil, nbDays: Int? = nil, isOpen: Int? = nil, completion: @escaping ([Festival]) -> Void) {
        
        var parameters: [String: Any] = [:]
            if let id = idFestival {
                parameters["idFestival"] = id
            }
            if let name = nameFestival {
                parameters["nameFestival"] = name
            }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                guard let urlString = "\(apiUrl)\(String(data: jsonData, encoding: .utf8)!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                      let url = URL(string: urlString) else {
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue("Bearer \(AuthHeader().authHeader())", forHTTPHeaderField: "Authorization")
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        return
                    }
                    guard let data = data,
                          let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [Festival] else {
                        return
                    }
                    completion(jsonObject)
                }.resume()
            } catch {
                return
            }
    }

    
}
