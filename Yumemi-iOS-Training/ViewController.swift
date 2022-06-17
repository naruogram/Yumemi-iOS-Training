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
        setImage(weather: weather)
    }

    @IBAction func didTapFetchWeatherButton(_ sender: Any) {
        fetchWeatherCondition()
    }
    
}

extension ViewController {
    func setImage(weather: String) {
        switch weather {
        case "sunny":
            self.weatherImageView.tintColor = .red
            self.weatherImageView.image = UIImage(named: "Sunny")
        case "cloudy":
            self.weatherImageView.tintColor = .gray
            self.weatherImageView.image = UIImage(named: "Cloudy")
        case "rainy":
            self.weatherImageView.tintColor = .blue
            self.weatherImageView.image = UIImage(named: "Rainy")
        default:
            return;
        }
    }
}
