//
//  WeatherResponse.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WeatherResponse {
    
    /// The current weather information.
    let current: CurrentWeather
    
    /// The information for the next 7 days weather.
    let daily: [DayWeather]
    
}

extension WeatherResponse {
    
    init(json: JSON) {
        current = CurrentWeather(json: json["current"])
        daily = json["daily"].arrayValue.compactMap { DayWeather(json: $0) }
    }
}
