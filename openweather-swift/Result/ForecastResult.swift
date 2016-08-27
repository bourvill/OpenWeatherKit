//
//  ForecastResult.swift
//  openweather-swift
//
//  Created by maxime marinel on 21/07/2016.
//  Copyright © 2016 maxime marinel. All rights reserved.
//

import UIKit

public struct ForecastResult {

    public let city: City
    public var list: [Int: Weather] = [:]

    init(data: NSDictionary) {
        self.city = City(id: data["city"]!["id"] as! Int, name: data["city"]!["name"] as! String, coord: data["city"]!["coord"] as! NSDictionary, country: data["city"]!["country"] as! String)

        for weather in data["list"] as! NSArray {
            list[weather["dt"] as! Int] = Weather(main: weather["main"] as! NSDictionary, weather: weather["weather"] as! NSArray)
        }
    }
}
