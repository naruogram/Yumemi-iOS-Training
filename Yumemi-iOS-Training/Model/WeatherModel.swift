//
//  WeatherModel.swift
//  Yumemi-iOS-Training
//
//  Created by 成尾 嘉貴 on 2022/06/21.
//

import Foundation
import YumemiWeather

struct WeatherModel {
    let dateUtils = DateUtils()
    
    func jsonString(request: Request) throws -> String{
        let encoder = JSONEncoder()
        let requestJsonValue = try? encoder.encode(request)
        let requestJsonString = String(bytes: requestJsonValue!, encoding: .utf8)
        return requestJsonString!
    }
    
    func response(response: String) throws -> Response {
        let decoder = JSONDecoder()
        let responseData = response.data(using: .utf8)
        let responseResult: Response = try decoder.decode(Response.self, from: responseData!)
        return responseResult
    }
    
    func fetchWeather(area: String,date:Date) throws -> Response {
        let date = dateUtils.stringFromDate(date: date, format:"yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        
        let request = Request(area: area, date: date)
        
        let jsonString = try? jsonString(request: request)
        
        let responseJson = try? YumemiWeather.fetchWeather(jsonString!)
        
        let response = try response(response: responseJson!)
        
        return response
    }
}
