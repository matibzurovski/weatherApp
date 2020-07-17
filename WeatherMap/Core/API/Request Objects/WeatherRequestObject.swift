//
//  WeatherRequestObject.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

struct WeatherRequestObject {
    
    let latitude: Double
    let longitude: Double

}

extension WeatherRequestObject {
    
    var parameters: [String: Any] {
        var result: [String: Any] = [:]
        result["lat"] = latitude
        result["lon"] = longitude
        result["exclude"] = "minutely,hourly"
        result["units"] = "imperial"
        result["appid"] = ApiConfiguration.apiKey
        
        return result
    }
}
