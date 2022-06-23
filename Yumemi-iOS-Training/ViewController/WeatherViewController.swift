//
//  ViewController.swift
//  Yumemi-iOS-Training
//
//  Created by 成尾 嘉貴 on 2022/06/16.
//

import UIKit
import YumemiWeather

class WeatherViewController: UIViewController {
    
    let weatherModel = WeatherModel()
    
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchWeather()
    }
    
    private func fetchWeather() {
        do {
            let weather = try weatherModel.fetchWeather(area: "tokyo", date: Date())
            handleWeather(weather: weather)
        }
        catch {
            presentErrorAlertDialog()
        }
    }
    
    private func handleWeather(weather: WeatherResponse) {
        minTempLabel.text = weather.minTemp.description
        maxTempLabel.text = weather.maxTemp.description
        setImage(weatherCondition: weather.weatherCondition)
    }
    
    @IBAction func didTapFetchWeatherButton(_ sender: Any) {
        fetchWeather()
    }
    
    @IBAction func didTapCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func presentErrorAlertDialog() {
        let alert = UIAlertController(title: "エラー", message: "エラーが発生しました", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension WeatherViewController {
    func setImage(weatherCondition: WeatherCondition) {
        switch weatherCondition {
        case .sunny:
            weatherImageView.tintColor = .red
        case .cloudy:
            weatherImageView.tintColor = .gray
        case .rainy:
            weatherImageView.tintColor = .blue
        }
        weatherImageView.image = UIImage(named: weatherCondition.iconName)
    }
}

extension WeatherCondition {
    var iconName: String {
        rawValue.capitalized
    }
}
