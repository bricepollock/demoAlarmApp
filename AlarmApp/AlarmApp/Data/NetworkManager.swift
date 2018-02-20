//
//  NetworkManager.swift
//  MountainProjectDemoApp
//
//  Created by Brice Pollock on 2/6/18.
//  Copyright © 2018 Brice Pollock. All rights reserved.
//

import Foundation

enum NetworkMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

struct NetworkManager {
    func makeURLRequest<T: Codable>(using method: NetworkMethod = .get, for url: URL, containing body: Data? = nil, with completion: @escaping (T?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        if method != .get {
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print("Error on request - \(String(describing: error))")
                completion(nil)
                return
            }
            guard let data = data else {
                print("Missing Data")
                completion(nil)
                return
            }
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(object)
            } catch {
                print("Unable to JSON decode")
                completion(nil)
            }
        }
        task.resume()
    }
}
