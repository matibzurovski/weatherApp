//
//  WeatherInfo.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import RealmSwift

/// This class will act as a DB entity but also as the view model that the `WeatherViewController` uses
class WeatherInfo: Object {
    
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var conditionDescription = ""
    @objc dynamic var conditionIcon = ""
    @objc dynamic var temperature: Double = 0.0
    @objc dynamic var feelsLike: Double = 0.0
    dynamic var days = List<DayWeatherInfo>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func configure(conditionDescription: String, conditionIcon: String, temperature: Double, feelsLike: Double, days: [DayWeatherInfo]) {
        self.conditionDescription = conditionDescription
        self.conditionIcon = conditionIcon
        self.temperature = temperature
        self.feelsLike = feelsLike
        self.days.append(objectsIn: days)
    }
}
