//
//  DayWeatherInfo.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import RealmSwift

class DayWeatherInfo: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var day = ""
    @objc dynamic var conditionIcon = ""
    @objc dynamic var minTemperature: Double = 0.0
    @objc dynamic var maxTemperature: Double = 0.0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func configure(day: String, conditionIcon: String, minTemperature: Double, maxTemperature: Double) {
        self.day = day
        self.conditionIcon = conditionIcon
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
    }
}
