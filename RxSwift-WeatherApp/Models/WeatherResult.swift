//
//  WeatherResult.swift
//  RxSwift-WeatherApp
//
//  Created by Aleksander Waage on 31/07/2020.
//  Copyright © 2020 Waageweb. All rights reserved.
//

import Foundation

struct WeaterResult: Decodable {
    let main: Weather
}

extension WeaterResult {
    static var  empty: WeaterResult {
        return WeaterResult(main: Weather(temp: 0.0, humidity: 0.0))
    }
}

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}
