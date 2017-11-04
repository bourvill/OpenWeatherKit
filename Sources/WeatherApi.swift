//
//  WeatherApi.swift
//  OpenWeatherKit
//
//  Created by maxime marinel on 03/11/2017.
//  Copyright © 2017 OpenWeatherKit. All rights reserved.
//

import Foundation

public enum WeatherError: Error {
    case invalidData
}

public enum Result<T> {
    case success(T)
    case error(Error?)
}

protocol WeatherApiProtocol {
    var key: String {get}
    var endpoint: String {get}
    var version: String {get}
    var urlSession: URLSessionProtocol {get}
    var defaultParameters: [URLQueryItem] {get}
    
    func getEndpoint() -> String
}

public protocol WeatherApiWeatherProtocol {
    func getWeatherFor(lat: String, lon: String, completion: @escaping (Result<Weather>) -> ())
    func getWeatherFor(cityId id: Int, completion: @escaping (Result<Weather>) -> ())
}

public protocol WeatherApiForecastProtocol {
    func getForecastFor(lat: String, lon: String, completion: @escaping (Result<Forecast>) -> ())
    func getForecastFor(cityId id: Int, completion: @escaping (Result<Forecast>) -> ())
}

public class WeatherApi: WeatherApiProtocol {
    var key: String
    var endpoint: String = "https://api.openweathermap.org/data"
    var version: String = "2.5"
    var urlSession: URLSessionProtocol
    var defaultParameters: [URLQueryItem] = []
    
    public init(key: String, urlSession: URLSessionProtocol) {
        self.key = key
        self.urlSession = urlSession
        self.defaultParameters.append(URLQueryItem(name: "APPID", value: key))
    }
    
    public convenience init(key: String) {
        self.init(key: key, urlSession: URLSession.shared)
    }
    
    func getEndpoint() -> String {
        return "\(endpoint)/\(version)/"
    }
    
    func addDefaultParameter(name: String, value: String) {
        defaultParameters.append(URLQueryItem(name: name, value: value))
    }
    
    private func send<T:Codable>(to endpoint: String, with parameters: [String:Any], completion: @escaping (Result<T>) -> ()) {
        var urlComponents = URLComponents(string: "\(getEndpoint())\(endpoint)")!
        urlComponents.queryItems = defaultParameters
        for (key, value) in parameters {
            urlComponents.queryItems?.append(URLQueryItem(name: key, value: (String(describing: value))))
        }
        
        urlSession.dataTask(with: urlComponents.url!) { data, response, error in
            guard let data = data else {
                completion(Result.error(WeatherError.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let weather = try decoder.decode(T.self, from: data)
                completion(Result.success(weather))
            } catch let error {
                completion(Result.error(error))
            }
            }.resume()
    }
}

extension WeatherApi: WeatherApiWeatherProtocol {
    public func getWeatherFor(lat: String, lon: String, completion: @escaping (Result<Weather>) -> ()) {
        send(to: "weather", with: ["lat": lat, "lon": lon], completion: completion)
    }
    public func getWeatherFor(cityId id: Int, completion: @escaping (Result<Weather>) -> ()) {
        send(to: "weather", with: ["id": id], completion: completion)
    }
}

extension WeatherApi: WeatherApiForecastProtocol {
    public func getForecastFor(lat: String, lon: String, completion: @escaping (Result<Forecast>) -> ()) {
        send(to: "forecast", with: ["lat": lat, "lon": lon], completion: completion)
    }
    public func getForecastFor(cityId id: Int, completion: @escaping (Result<Forecast>) -> ()) {
        send(to: "forecast", with: ["id": id], completion: completion)
    }
}
