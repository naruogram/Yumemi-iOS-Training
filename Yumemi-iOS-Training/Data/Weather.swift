//
//  Weather.swift
//  Yumemi-iOS-Training
//
//  Created by 成尾 嘉貴 on 2022/06/20.
//

import Foundation

enum Weather: String, Codable
{
    case sunny
    case cloudy
    case rainy
    
    func toUpperCaseFirstLetter() -> String {
        switch self {
        case .sunny:
            return "Sunny"
        case .cloudy:
            return "Cloudy"
        case .rainy:
            return "Rainy"
        }
    }
}
