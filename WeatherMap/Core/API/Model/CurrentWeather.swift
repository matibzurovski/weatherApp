//
//  CurrentWeather.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import SwiftyJSON

/// The weather details corresponding to one particular day.
struct CurrentWeather {
    
    /// The temperature in Fahrenheit.
    let temperature: Double
    
    /// The human perception of the temperature.
    let feelsLike: Double
    
    /// The conditions of the weather.
    let conditions: [WeatherCondition]
}

extension CurrentWeather {
    
    init(json: JSON) {
        temperature = json["temp"].doubleValue
        feelsLike = json["feels_like"].doubleValue
        conditions = json["weather"].arrayValue.compactMap { WeatherCondition(json: $0) }
    }
}
