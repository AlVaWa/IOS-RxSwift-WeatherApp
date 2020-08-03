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
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=83750e57616d8f55870e60ae1433a667&units=metric")
    }
    
}
