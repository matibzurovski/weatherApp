//
//  WeatherCondition.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WeatherCondition {
    
    /// The main description of the weather condition.
    let main: String
    
    /// The icon corresponding to this condition.
    let icon: String
}

extension WeatherCondition {
    
    init(json: JSON) {
        main = json["main"].stringValue
        icon = json["icon"].stringValue
    }
}

extension WeatherCondition {
    
    var iconUrl: String {
        return "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
}
