//
//  Weather.swift
//  WeatherApp
//
//  Created by Deepthi Rao on 8/21/24.
//

import Foundation

struct Weather: Decodable {
    let id: Int
    let name: String
    let main: Main
    let weather: [WeatherInfo]
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}

struct WeatherInfo: Decodable {
    let id: Int
    let main: String
    let description: String
}
