//
//  TemperatureDetails.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import SwiftyJSON

/// The details of a temperature
struct TemperatureDetails {
    
    /// Min temperature, in Fahrenheit.
    let min: Double
    
    /// Max temperature, in Fahrenheit.
    let max: Double
    
    /// Day temperature, in Fahrenheit.
    let day: Double
    
    /// Night temperature, in Fahrenheit.
    let night: Double
}

extension TemperatureDetails {
    
    init(json: JSON) {
        min = json["min"].doubleValue
        max = json["max"].doubleValue
        day = json["day"].doubleValue
        night = json["night"].doubleValue
    }
}
