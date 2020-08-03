//
//  URL+Extensions.swift
//  RxSwift-WeatherApp
//
//  Created by Aleksander Waage on 31/07/2020.
//  Copyright © 2020 Waageweb. All rights reserved.
//

import Foundation

extension URL {
    
    static func urlForWeatherAPI(city: String) -> URL? {
        if let apiKey = ProcessInfo.processInfo.environment["WeatherAPIKey"] {
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=\(apiKey)&units=metric")
        } else {
            return nil
        }
    }
    
}
