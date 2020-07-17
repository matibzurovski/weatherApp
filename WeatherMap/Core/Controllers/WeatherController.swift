//
//  WeatherController.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

protocol WeatherControllerDelegate: class {
    func weatherController(_ controller: WeatherController, didObtainWeather weather: WeatherResponse)
    func weatherController(_ controller: WeatherController, didFailWithError error: Error)
}

class WeatherController {
    
    fileprivate let api: Api
    private var isLoading = false
    
    init(api: Api = Api()) {
        self.api = api
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
                self.delegate?.weatherController(self, didObtainWeather: weather)
            case .error(let error):
                self.delegate?.weatherController(self, didFailWithError: error)
            }
        }
    }
}
