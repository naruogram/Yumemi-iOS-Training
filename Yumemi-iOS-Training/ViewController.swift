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
        setImage(weather: fetchWeatherCondition())
    }
    
    public func fetchWeatherCondition() -> String {
        let weather = YumemiWeather.fetchWeatherCondition()
        return weather
    }

    @IBAction func fetchWeatherBtn(_ sender: Any) {
        setImage(weather: fetchWeatherCondition())
    }
}

extension ViewController {
    func setImage(weather: String) {
        switch weather {
        case "sunny":
            self.weatherImageView.tintColor = .red
        case "cloudy":
            self.weatherImageView.tintColor = .gray
        case "rainy":
            self.weatherImageView.tintColor = .blue
        default:
            return;
        }
        self.weatherImageView.image = UIImage(named: weather)
    }
}
