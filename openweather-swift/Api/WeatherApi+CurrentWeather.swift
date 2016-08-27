//
//  WeatherApi+CurrentWeather.swift
//  openweather-swift
//
//  Created by maxime marinel on 11/08/2016.
//  Copyright © 2016 maxime marinel. All rights reserved.
//

import Foundation

extension WeatherApi {
    static public func currentWeather(latitude: String, longitude: String, callback: (WeatherResult?) -> ()) {
        send("weather", param: "lat=\(latitude)&lon=\(longitude)") { result in
            guard let data = result.data() else {
                callback(nil)
                return
            }
            callback(WeatherResult(city: City(id: data["id"] as! Int, name: data["name"] as! String, coord: data["coord"] as! NSDictionary), main: data["main"] as! NSDictionary, weather: data["weather"] as! NSArray))
        }
    }

    static public func currentWeather(cityId: Int, callback: (WeatherResult?) -> ()) {
        send("weather", param: "id=\(cityId)") { result in
            guard let data = result.data() else {
                callback(nil)
                return
            }
            callback(WeatherResult(city: City(id: data["id"] as! Int, name: data["name"] as! String, coord: data["coord"] as! NSDictionary), main: data["main"] as! NSDictionary, weather: data["weather"] as! NSArray))
        }
    }

    static public func currentWeather(city: String, callback: (WeatherResult?) -> ()) {
        send("weather", param: "q=\(city)") { result in
            guard let data = result.data() else {
                callback(nil)
                return
            }
            callback(WeatherResult(city: City(id: data["id"] as! Int, name: data["name"] as! String, coord: data["coord"] as! NSDictionary), main: data["main"] as! NSDictionary, weather: data["weather"] as! NSArray))
        }
    }
}
