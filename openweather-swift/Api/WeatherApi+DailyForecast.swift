//
//  WeatherApi+DailyForecast.swift
//  openweather-swift
//
//  Created by maxime marinel on 11/08/2016.
//  Copyright © 2016 maxime marinel. All rights reserved.
//

import Foundation

extension WeatherApi {
    static public func dailyForecast(latitude: String, longitude: String, callback: (ForecastResult?) -> ()) {
        send("forecast", param: "lat=\(latitude)&lon=\(longitude)") { result in
            switch result {
            case .Success:
                callback(ForecastResult(data: result.data()!))
                break
            case .Error:
                callback(nil)
                break
            }
        }
    }

    static public func dailyForecast(city: String, callback: (ForecastResult?) -> ()) {
        send("forecast", param: "q=\(city)") { result in
            switch result {
            case .Success:
                callback(ForecastResult(data: result.data()!))
                break
            case .Error:
                callback(nil)
                break
            }
        }
    }

    public func dailyForecast(cityId: Int, callback: (Result) -> ()) {
        // send("/forecast/daily?id=\(cityId)", callback: callback)
    }
}
