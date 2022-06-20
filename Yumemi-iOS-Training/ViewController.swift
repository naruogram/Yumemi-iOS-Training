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
    
    private func fetchWeatherCondition() {
        do {
            let weather = try YumemiWeather.fetchWeatherCondition(at: "tokyo")
            setImage(weather: Weather(rawValue: weather)!)
        } catch {
            presentErrorAlertDialog()
        }
    }
    
    @IBAction func didTapFetchWeatherButton(_ sender: Any) {
        fetchWeatherCondition()
    }
    
    private func presentErrorAlertDialog() {
        let alert = UIAlertController(title: "エラー", message: "エラーが発生しました", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "はい", style: .default)
        let noAction = UIAlertAction(title: "いいえ", style: .destructive)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
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
