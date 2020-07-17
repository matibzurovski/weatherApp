//
//  DailyWeatherTableViewCell.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "DailyWeatherTableViewCell"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    func load(weather: DayWeatherInfo) {
        dateLabel.text = weather.day
        if let url = URL(string: weather.conditionIcon) {
            iconImageView.af.setImage(withURL: url)
        }
        temperatureLabel.text = "\(weather.minTemperature)° - \(weather.maxTemperature)°"
    }
}

extension Date {
    
    var dayOfWeek: String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EEEE"
        return dateformatter.string(from: self)
    }
}
