//
//  Request.swift
//  Yumemi-iOS-Training
//
//  Created by 成尾 嘉貴 on 2022/06/20.
//

import Foundation

struct WeatherRequest: Encodable {
    let area: String
    let date: Date
}
