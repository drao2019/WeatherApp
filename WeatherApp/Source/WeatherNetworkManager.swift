//
//  WeatherNetworkManager.swift
//  WeatherApp
//
//  Created by Deepthi Rao on 8/22/24.
//

import Foundation
import SwiftUI

actor WeatherNetworkManager {
    
    static func fetchData(for url: String?, completion: @escaping (Weather?)->()) {
        guard var url = url else {
            print("Invalid empty url, return")
            completion(nil)
            return
        }
        
        guard let urlStr = URL(string: url) else {
            print("Failed to construct url, return")
            completion(nil)
            return
        }
        let urlRequest = URLRequest(url: urlStr)

        print("Fetching weather for url: \(urlStr)")
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, resp, error) in
            
            guard let data = data, error == nil else {
                print("Received error or invalid data")
                completion(nil)
                return
            }
            
            do {
                let jsonResp = try JSONDecoder().decode(Weather.self, from: data)
                print("Received json: \(jsonResp)")
                completion(jsonResp)
            }
            catch {
                print("Failed to decode data")
                completion(nil)
            }
        })
        .resume()
    }
    
    // https://openweathermap.org/img/wn/10d@2x.png
    static func fetchImage(for url: String?, completion: @escaping (Data?)->()) {
        guard var url = url else {
            print("Invalid empty url, return")
            completion(nil)
            return
        }

        guard let urlStr = URL(string: url) else {
            print("Failed to construct url, return")
            completion(nil)
            return
        }
        let urlRequest = URLRequest(url: urlStr)

        print("Fetching weather for url: \(urlStr)")
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, resp, error) in
            
            guard let data = data, error == nil else {
                print("Received error or invalid data")
                completion(nil)
                return
            }
            
            do {
//                let jsonResp = try JSONDecoder().decode(Weather.self, from: data)
                print("Received Image data)")
                completion(data)
            }
            catch {
                print("Failed to decode data")
                completion(nil)
            }
        })
        .resume()
    }
}
