//
//  WeatherViewController.swift
//  WeatherMap
//
//  Created by Matias Bzurovski on 17/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import AlamofireImage

class WeatherViewController: UIViewController {
    
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var iconImageView: UIImageView!
    @IBOutlet fileprivate weak var temperatureLabel: UILabel!
    @IBOutlet fileprivate weak var feelsLikeLabel: UILabel!
    @IBOutlet fileprivate weak var daysTableView: UITableView!
    
    fileprivate let response: WeatherResponse
    
    init(response: WeatherResponse) {
        self.response = response
        super.init(nibName: "WeatherViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setUpTableView()
    }
}

fileprivate extension WeatherViewController {
    
    func loadData() {
        if let condition = response.current.conditions.first {
            descriptionLabel.text = condition.main
            if let url = condition.iconUrl {
                iconImageView.af.setImage(withURL: url)
            }
        }
        temperatureLabel.text = "\(response.current.temperature)°"
        feelsLikeLabel.text = "(feels like \(response.current.feelsLike)°)"
    }
    
    func setUpTableView() {
        daysTableView.dataSource = self
        daysTableView.allowsSelection = false
        
        let nib = UINib(nibName: "DailyWeatherTableViewCell", bundle: nil)
        daysTableView.register(nib, forCellReuseIdentifier: DailyWeatherTableViewCell.reuseIdentifier)
    }
}

extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response.daily.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherTableViewCell.reuseIdentifier, for: indexPath) as? DailyWeatherTableViewCell else {
            return UITableViewCell()
        }
        
        let weather = response.daily[indexPath.row]
        cell.load(weather: weather)
        return cell
    }
}
