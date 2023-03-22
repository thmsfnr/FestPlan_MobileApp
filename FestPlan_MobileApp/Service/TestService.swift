//
//  TestService.swift
//  FestPlan_MobileApp
//
//  Created by Thomas Fournier on 22/03/2023.
//

import Foundation
import SwiftUI

class TestService {
    
    let apiUrl = ApiConfig().url + "/test/"
    
    func isPublic(completion: @escaping (Bool, Error?) -> ()) {

        let url = URL(string: "\(apiUrl)public")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
            
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error)
                return
            }
                
            guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                completion(false, nil)
                return
            }
                
            completion(true, nil)
        }.resume()
    }
    
    func isUser(completion: @escaping (Bool, Error?) -> ()) {

        let url = URL(string: "\(apiUrl)user")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("\(AuthHeader.authHeader())", forHTTPHeaderField: "x-access-token")
            
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error)
                return
            }
                
            guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                completion(false, nil)
                return
            }
                
            completion(true, nil)
        }.resume()
    }
    
    func isAdmin(completion: @escaping (Bool, Error?) -> ()) {

        let url = URL(string: "\(apiUrl)admin")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("\(AuthHeader.authHeader())", forHTTPHeaderField: "x-access-token")
            
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error)
                return
            }
                
            guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                completion(false, nil)
                return
            }
                
            completion(true, nil)
        }.resume()
    }
    
}

