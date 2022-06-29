//
//  ViewController.swift
//  Yumemi-iOS-Training
//
//  Created by 成尾 嘉貴 on 2022/06/16.
//

import UIKit
import YumemiWeather

class WeatherViewController: UIViewController {
    
    var weatherModel: WeatherModel
    
    init?(weatherModel: WeatherModel, coder: NSCoder) {
        self.weatherModel = weatherModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder){
        fatalError("error")
    }
    
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var fetchWeatherButtonFlag:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { [unowned self] notification in
            fetchWeather()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchWeather()
    }
    
    private func fetchWeather() {
        startLoadingAnimation()
        fetchWeatherButtonFlag = true
        weatherModel.fetchWeather(area: "tokyo", date: Date()) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.handleWeather(weather: response)
                case .failure(_):
                    self.presentErrorAlertDialog()
                }
                self.fetchWeatherButtonFlag = false
                self.stopLoadingAnimation()
            }
        }
    }
    
    
    private func handleWeather(weather: WeatherResponse) {
        minTempLabel.text = weather.minTemp.description
        maxTempLabel.text = weather.maxTemp.description
        setImage(weatherCondition: weather.weatherCondition)
    }
    
    private func startLoadingAnimation() {
        activityIndicatorView.startAnimating()
    }
    
    private func stopLoadingAnimation() {
        activityIndicatorView.stopAnimating()
    }
    
    @IBAction func didTapFetchWeatherButton(_ sender: Any) {
        if(fetchWeatherButtonFlag==false){
            fetchWeather()
        }
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
