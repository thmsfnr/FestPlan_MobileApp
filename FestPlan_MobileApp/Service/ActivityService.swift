//
//  ActivityService.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 14/03/2023.
//

import Foundation
import SwiftUI

let url = ApiConfig().url + "/activity/"

class ActivityService {
    
    func getActivity(idActivity: Int? = nil, nameActivity: String? = nil, type: Int? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
            var params: [String: Any] = [:]
            if let idActivity = idActivity {
                params["idActivity"] = idActivity
            }
            if let nameActivity = nameActivity {
                params["nameActivity"] = nameActivity
            }
            if let type = type {
                params["type"] = type
            }
            let stringifiedParams = try? JSONSerialization.data(withJSONObject: params)
            let queryString = stringifiedParams?.base64EncodedString()
            let url = URL(string: url + queryString!)!
        let headers = AuthHeader().authHeader()
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(NSError(domain: "ActivityAPI", code: -1, userInfo: nil)))
                }
            }
            task.resume()
        }
    
}
