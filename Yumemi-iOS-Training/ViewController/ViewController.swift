//
//  ViewController.swift
//  Yumemi-iOS-Training
//
//  Created by 成尾 嘉貴 on 2022/06/16.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {
    let weatherModel = WeatherModel()
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherCondition()
    }
    
    private func fetchWeatherCondition() {
        guard let weather = try? weatherModel.fetchWeather(area: "tokyo", date: Date()) else{
           return presentErrorAlertDialog()
        }
        handleWeather(weather: weather)
    }
    
    private func handleWeather(weather: Response){
        lowTempLabel.text = weather.minTemp.description
        highTempLabel.text = weather.maxTemp.description
        setImage(weather: weather.weather)
    }
    
    @IBAction func didTapFetchWeatherButton(_ sender: Any) {
        fetchWeatherCondition()
    }
    
    private func presentErrorAlertDialog() {
        let alert = UIAlertController(title: "エラー", message: "エラーが発生しました", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController {
    func setImage(weather: Weather) {
        switch weather {
        case .sunny:
            weatherImageView.tintColor = .red
        case .cloudy:
            weatherImageView.tintColor = .gray
        case .rainy:
            weatherImageView.tintColor = .blue
        }
        weatherImageView.image = UIImage(named: weather.toUpperCaseFirstLetter())
    }
}
