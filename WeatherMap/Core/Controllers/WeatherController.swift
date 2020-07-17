//
//  WeatherController.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

protocol WeatherControllerDelegate: class {
    func weatherController(_ controller: WeatherController, didObtainWeather weather: WeatherInfo)
    func weatherController(_ controller: WeatherController, didFailWithError error: Error)
}

class WeatherController {
    
    fileprivate let api: Api
    fileprivate let persistenceController: PersistenceController
    
    private var isLoading = false
    
    init(api: Api = Api(), persistenceController: PersistenceController = PersistenceController.shared) {
        self.api = api
        self.persistenceController = persistenceController
    }
    
    weak var delegate: WeatherControllerDelegate?
    
    func fetchWeather(latitude: Double, longitude: Double) {
        /// Prevent multiple requests at the same time, so that we don't overflood the API (which has some limitations for free users)
        guard !isLoading else { return }
        isLoading = true
        
        let requestObject = WeatherRequestObject(latitude: latitude, longitude: longitude)
        api.fetchWeather(requestObject: requestObject) { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response {
            case .success(let weather):
                let info = self.generateWeatherInfo(weather: weather)
                self.updateWeatherInfo(info: info)
                self.delegate?.weatherController(self, didObtainWeather: info)
            case .error(let error):
                self.delegate?.weatherController(self, didFailWithError: error)
            }
        }
    }
    
    private func generateWeatherInfo(weather: WeatherResponse) -> WeatherInfo {
        var days: [DayWeatherInfo] = []
        for day in weather.daily {
            guard let condition = day.conditions.first else { continue }
            let dayInfo = DayWeatherInfo()
            dayInfo.configure(day: day.date.dayOfWeek, conditionIcon: condition.iconUrl, minTemperature: day.tempeature.min, maxTemperature: day.tempeature.max)
            days.append(dayInfo)
        }
        
        let info = WeatherInfo()
        let condition = weather.current.conditions.first
        info.configure(conditionDescription: condition?.main ?? "", conditionIcon: condition?.iconUrl ?? "", temperature: weather.current.temperature, feelsLike: weather.current.feelsLike, days: days)
        
        return info
        
    }
    
    private func updateWeatherInfo(info: WeatherInfo) {
        do {
            try persistenceController.deleteAllObjectsOfType(WeatherInfo.self)
            try persistenceController.createObject(info, update: .modified)
        } catch let error {
            print("Error when trying to save weather info. Error: \(error)")
        }
    }
}
