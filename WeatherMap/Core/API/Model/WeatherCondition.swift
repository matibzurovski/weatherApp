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
    
    /// The description of the weather condition.
    let description: String
    
    /// The icon corresponding to this condition.
    let icon: String
}

extension WeatherCondition {
    
    init(json: JSON) {
        description = json["description"].stringValue
        icon = json["icon"].stringValue
    }
}
