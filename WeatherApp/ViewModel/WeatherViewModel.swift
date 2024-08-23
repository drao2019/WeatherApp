//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Deepthi Rao on 8/21/24.
//

import Foundation
import Observation

class WeatherViewModel: ObservableObject {
    @Published var model: Weather?
    @Published var showAlert = false
    @Published var showErrorMessage = ""
    
    var temperature : Int {
        return Int(model?.main.temp ?? 0)
    }
    
    var minTemperature : Int {
        return Int(model?.main.temp_min ?? 0)
    }

    var maxTemperature : Int {
        return Int(model?.main.temp_max ?? 0)
    }

    func fetchWeatherReport(for city: String) {
        if city.isEmpty == true {
            self.showAlert = true
            self.showErrorMessage = "Please enter valid city to continue"
            return
        }
        
        UserDefaults.standard.setValue(city, forKey: "lastSavedLocationKey")
        // construct full url having city and apiKey
        let weatherUrl = WeatherConstants.weatherUrl+"\(city)&US&APPID=\(WeatherConstants.apiKey)&&units=metric"
        WeatherNetworkManager.fetchData(for: weatherUrl, completion: { [weak self] weather in
            DispatchQueue.main.async {
                if let weather = weather {
                    self?.model = weather
                    UserDefaults.standard.setValue(city, forKey: "lastSavedLocationKey")
                }
                else {
                    self?.showAlert = true
                    self?.showErrorMessage = "Failed to fetch weather report for city \(city)"
                    self?.model = nil
                }
            }
        })
    }
}
