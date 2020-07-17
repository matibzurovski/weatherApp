//
//  DayWeather.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import SwiftyJSON

/// The weather corresponding to one particular day.
struct DayWeather {
    
    /// Date to which this weather corresponds to.
    let date: Date
    
    /// Sunrise time.
    let sunrise: Date
    
    /// Sunset time.
    let sunset: Date
    
    /// The temperature details for this day.
    let tempeature: TemperatureDetails
    
    /// The conditions of the weather
    let conditions: [WeatherCondition]
}

extension DayWeather {
    
    init(json: JSON) {
        date = Date(timeIntervalSince1970: json["dt"].doubleValue)
        sunrise = Date(timeIntervalSinceReferenceDate: json["sunrise"].doubleValue)
        sunset = Date(timeIntervalSinceReferenceDate: json["sunset"].doubleValue)
        tempeature = TemperatureDetails(json: json["temp"])
        conditions = json["weather"].arrayValue.compactMap { WeatherCondition(json: $0) }
    }
}
