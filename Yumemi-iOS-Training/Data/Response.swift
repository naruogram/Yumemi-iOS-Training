//
//  Response.swift
//  Yumemi-iOS-Training
//
//  Created by 成尾 嘉貴 on 2022/06/20.
//

import Foundation

struct Response: Codable {
    let weather: Weather
    let maxTemp: Int
    let minTemp: Int
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case weather = "weather_condition"
        case maxTemp = "max_temperature"
        case minTemp = "min_temperature"
        case date
    }
}

