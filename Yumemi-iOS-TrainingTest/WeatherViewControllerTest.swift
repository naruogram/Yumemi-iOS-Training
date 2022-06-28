//
//  Yumemi_iOS_TrainingTest.swift
//  Yumemi-iOS-TrainingTest
//
//  Created by 成尾 嘉貴 on 2022/06/27.
//

import XCTest
@testable
import Yumemi_iOS_Training

class MockWeatherModel: WeatherModel {
    
    var weatherResponse: (() throws -> WeatherResponse)?

    func fetchWeather(area: String, date: Date) throws -> WeatherResponse {
        guard let response = try weatherResponse?() else {
            throw WeatherError.unknownError
        }
        return response
    }
    
    
    
    
}

class WeatherViewControllerTest: XCTestCase {
    
    var viewController: WeatherViewController!
    let weatherModel = MockWeatherModel()
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        viewController = storyboard.instantiateViewController(identifier: "weatherViewController", creator: { coder in
            WeatherViewController(weatherModel: self.weatherModel, coder: coder)
        })
        
        viewController.loadViewIfNeeded()
    }
    
    func testSunny() {
        weatherModel.weatherResponse = {
            WeatherResponse(weatherCondition: .sunny, maxTemp: 0, minTemp: 0, date: Date())
        }
        
        viewController.didTapFetchWeatherButton(self)

        XCTAssertNotNil(viewController.weatherImageView.image)
        XCTAssertEqual(viewController.weatherImageView.image, UIImage(named: "Sunny"))
    }
    
    func testCloudy() {
        weatherModel.weatherResponse = {
            WeatherResponse(weatherCondition: .cloudy, maxTemp: 0, minTemp: 0, date: Date())
        }
        
        viewController.didTapFetchWeatherButton(self)
        
        XCTAssertNotNil(viewController.weatherImageView.image)
        XCTAssertEqual(viewController.weatherImageView.image, UIImage(named: "Cloudy"))
    }
    
    func testRainy() {
        weatherModel.weatherResponse = {
            WeatherResponse(weatherCondition: .rainy, maxTemp: 0, minTemp: 0, date: Date())
        }
        
        viewController.didTapFetchWeatherButton(self)
        
        XCTAssertNotNil(viewController.weatherImageView.image)
        XCTAssertEqual(viewController.weatherImageView.image, UIImage(named: "Rainy"))
    }
    
    func testMaxTempLabel() {
        weatherModel.weatherResponse = {
            WeatherResponse(weatherCondition: .rainy, maxTemp: 20, minTemp: 10, date: Date())
        }
        
        viewController.didTapFetchWeatherButton(self)
        
        XCTAssertNotNil(viewController.minTempLabel.text)
        XCTAssertEqual(viewController.maxTempLabel.text, "20")
    }
    
    func testMinTempLabel() {
        weatherModel.weatherResponse = {
            WeatherResponse(weatherCondition: .rainy, maxTemp: 20, minTemp: 10, date: Date())
        }
        
        viewController.didTapFetchWeatherButton(self)
        
        XCTAssertNotNil(viewController.minTempLabel.text)
        XCTAssertEqual(viewController.minTempLabel.text, "10")
    }
}
