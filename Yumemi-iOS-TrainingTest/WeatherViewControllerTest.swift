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
    
    func fetchWeather(area: String, date: Date, completion: @escaping (Result<WeatherResponse, WeatherError>) -> Void) {
        guard let response = try? weatherResponse?() else {
            XCTFail()
            completion(.failure(.unknownError))
            return
        }
        completion(.success(response))
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
        let expectetion = XCTestExpectation(description: "maxTempLabel")
         weatherModel.weatherResponse = {
             defer {
                 DispatchQueue.main.async {
                     expectetion.fulfill()
                 }
             }
             return WeatherResponse(weatherCondition: .sunny, maxTemp: 20, minTemp: 10, date: Date())
         }
        
        viewController.didTapFetchWeatherButton(self)
        wait(for: [expectetion], timeout: 5)
        
        XCTAssertNotNil(viewController.maxTempLabel.text)
        XCTAssertEqual(viewController.maxTempLabel.text, "20")
    }
    
    func testMinTempLabel() {
        let expectetion = XCTestExpectation(description: "minTempLabel")
         weatherModel.weatherResponse = {
             defer {
                 DispatchQueue.main.async {
                     expectetion.fulfill()
                 }
             }
             return WeatherResponse(weatherCondition: .sunny, maxTemp: 20, minTemp: 10, date: Date())
         }
        
        viewController.didTapFetchWeatherButton(self)
        wait(for: [expectetion], timeout: 5)
        
        XCTAssertNotNil(viewController.minTempLabel.text)
        XCTAssertEqual(viewController.minTempLabel.text, "10")
    }
}

extension WeatherViewControllerTest {
    
    func testWeatherCondition(weatherCondition: WeatherCondition) {
        let expectetion = XCTestExpectation(description: "weatherResponse")
         weatherModel.weatherResponse = {
             defer {
                 DispatchQueue.main.async {
                     expectetion.fulfill()
                 }
             }
             return WeatherResponse(weatherCondition: weatherCondition, maxTemp: 0, minTemp: 0, date: Date())
         }
        
        viewController.didTapFetchWeatherButton(self)
        wait(for: [expectetion], timeout: 5)
        
        XCTAssertNotNil(viewController.weatherImageView.image)
        XCTAssertEqual(viewController.weatherImageView.image, UIImage(named: weatherCondition.iconName))
    }
}
