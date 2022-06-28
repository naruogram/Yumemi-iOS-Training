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
            XCTFail("not found weather response")
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
        testWeatherCondition(weatherCondition: .sunny)
    }
    
    func testCloudy() {
        testWeatherCondition(weatherCondition: .cloudy)
    }
    
    func testRainy() {
        testWeatherCondition(weatherCondition: .rainy)
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

extension WeatherViewControllerTest {
    
    func testWeatherCondition(weatherCondition: WeatherCondition) {
        weatherModel.weatherResponse = {
            WeatherResponse(weatherCondition: weatherCondition, maxTemp: 0, minTemp: 0, date: Date())
        }
        
        viewController.didTapFetchWeatherButton(self)
        
        XCTAssertNotNil(viewController.weatherImageView.image)
        XCTAssertEqual(viewController.weatherImageView.image, UIImage(named: weatherCondition.iconName))
    }
}
