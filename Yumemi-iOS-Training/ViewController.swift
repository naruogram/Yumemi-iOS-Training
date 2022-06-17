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
        do {
            let weather = try YumemiWeather.fetchWeatherCondition(at: "tokyo")
            setImage(weather: weather)
        } catch {
            presentErrorAlertDialog()
        }
    }
    
    @IBAction func didTapFetchWeatherButton(_ sender: Any) {
        fetchWeatherCondition()
    }
    
    func presentErrorAlertDialog() {
        let alert = UIAlertController(title: "エラー", message: "エラーが発生しました", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "はい", style: .default)
        let noAction = UIAlertAction(title: "いいえ", style: .destructive)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
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
