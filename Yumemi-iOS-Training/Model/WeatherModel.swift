//
//  WeatherModel.swift
//  Yumemi-iOS-Training
//
//  Created by 成尾 嘉貴 on 2022/06/21.
//

import Foundation
import YumemiWeather

protocol WeatherModel {
    func fetchWeather(area: String, date: Date, completion: @escaping (Result<WeatherResponse, WeatherError>) -> Void)
}

class WeatherModelImpl: WeatherModel {
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter
    }
    
    func jsonString(request: WeatherRequest) throws -> String {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        let requestJsonValue = try encoder.encode(request)
        guard let requestJsonString = String(data: requestJsonValue, encoding: .utf8) else {
            throw WeatherError.jsonEncodeError
        }
        return requestJsonString
    }
    
    func response(response: String) throws -> WeatherResponse {
        guard let responseData = response.data(using: .utf8) else {
            throw WeatherError.jsonDecodeError
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        let responseResult: WeatherResponse = try decoder.decode(WeatherResponse.self, from: responseData)
        return responseResult
    }
    
    func fetchWeather(area: String, date: Date, completion: @escaping (Result<WeatherResponse, WeatherError>) -> Void) {
        DispatchQueue.global().async {
            do {
                let request = WeatherRequest(area: area, date: date)
                let jsonString = try self.jsonString(request: request)
                let responseJson = try YumemiWeather.syncFetchWeather(jsonString)
                let response =  try self.response(response: responseJson)
                completion(.success(response))
            }
            catch {
                completion(.failure(WeatherError.jsonDecodeError))
            }
        }
    }
}
