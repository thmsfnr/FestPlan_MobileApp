//
//  ActivityService.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 14/03/2023.
//

import Foundation
import SwiftUI

let apiUrl = ApiConfig().url + "/activity/{}"

struct ActivityAPI: Codable, Equatable, Hashable {
    let idActivity: Int
    let nameActivity: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idActivity)
        hasher.combine(nameActivity)
    }
}


class ActivityService {
    
    func getActivity(idActivity: Int? = nil, nameActivity: String? = nil, type: String? = nil, completion: @escaping ([ActivityAPI]) -> Void) {
        var components = URLComponents(string: apiUrl)!

        guard let url = components.url else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            print(String(data: data, encoding: .utf8)!)
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let activities = try decoder.decode([ActivityAPI].self, from: data)
                completion(activities)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }

    
}
