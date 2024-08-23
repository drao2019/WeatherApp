//
//  WeatherLocationManager.swift
//  WeatherApp
//
//  Created by Deepthi Rao on 8/22/24.
//

import Foundation
import CoreLocation

class WeatherLocationManager: NSObject,ObservableObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    @Published var locationAuthorizationStatus: CLAuthorizationStatus?
    @Published var currentLocation = ""
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            locationAuthorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            break
            
        case .restricted:
            locationAuthorizationStatus = .restricted
            break

        case .denied:
            locationAuthorizationStatus = .denied
            break

        case .notDetermined:
            locationAuthorizationStatus = .notDetermined
            locationManager.requestWhenInUseAuthorization()
            break

        default:
            locationAuthorizationStatus = .authorizedWhenInUse
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location manager received location")
        UserDefaults.standard.setValue("<DUMMY_NAME>", forKey: "savedLocationKey")
        convertLocationToGeoName(manager)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Location manager failed with error - \(error.localizedDescription)")
    }
    
    private func convertLocationToGeoName(_ manager: CLLocationManager) {
        if let lastLocation = manager.location {
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(lastLocation, completionHandler: { (locations, error) in
                guard error == nil, let placess = locations, placess.isEmpty == false  else {
                    return
                }

                if let place = locations?.last {
                    self.parseLocation(place)
                }
            })
        }
    }
    
    private func parseLocation(_ place: CLPlacemark) {
        print("parseLocation: \(place.locality), postalCode: \(place.postalCode)")

        if let city = place.locality {
            // persist in UserDefault, and retrive it upon app launch to fetch the weather automatically
            currentLocation = city
            UserDefaults.standard.setValue(city, forKey: "lastSavedLocationKey")
        }
    }
}
