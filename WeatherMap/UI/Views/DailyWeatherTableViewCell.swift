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
    
    
    func load(weather: DayWeather) {
        dateLabel.text = weather.date.dayOfWeek
        if let condition = weather.conditions.first, let url = condition.iconUrl {
            iconImageView.af.setImage(withURL: url)
        }
        temperatureLabel.text = "\(weather.tempeature.min)° - \(weather.tempeature.max)°"
    }
}

private extension Date {
    
    var dayOfWeek: String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "EEEE"
        return dateformatter.string(from: self)
    }
}
