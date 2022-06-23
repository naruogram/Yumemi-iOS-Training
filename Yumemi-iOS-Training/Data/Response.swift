//
//  Response.swift
//  Yumemi-iOS-Training
//
//  Created by 成尾 嘉貴 on 2022/06/20.
//

import Foundation

struct WeatherResponse: Codable {
    let weatherCondition: WeatherCondition
    let maxTemp: Int
    let minTemp: Int
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case weatherCondition = "weather_condition"
        case maxTemp = "max_temperature"
        case minTemp = "min_temperature"
        case date
    }
}

