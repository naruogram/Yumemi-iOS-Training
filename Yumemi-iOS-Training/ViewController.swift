//
//  ViewController.swift
//  Yumemi-iOS-Training
//
//  Created by 成尾 嘉貴 on 2022/06/16.
//

import UIKit
import YumemiWeather
class ViewController: UIViewController {
    @IBOutlet weak var weatherImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherCondition()
    }
    
    public func fetchWeatherCondition() {
        let weather = YumemiWeather.fetchWeatherCondition()
        setImage(weather: Weather(rawValue: weather)!)
    }

    @IBAction func didTapFetchWeatherButton(_ sender: Any) {
        fetchWeatherCondition()
    }
    
}

extension ViewController {
    func setImage(weather: Weather) {
        switch weather {
        case .sunny:
            weatherImageView.tintColor = .red
            weatherImageView.image = UIImage(named: "Sunny")
        case .cloudy:
            weatherImageView.tintColor = .gray
            weatherImageView.image = UIImage(named: "Cloudy")
        case .rainy:
            weatherImageView.tintColor = .blue
            weatherImageView.image = UIImage(named: "Rainy")
        }
    }
}
