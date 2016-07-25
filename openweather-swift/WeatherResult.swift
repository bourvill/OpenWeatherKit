//
//  WeatherResult.swift
//  openweather-swift
//
//  Created by maxime marinel on 20/07/2016.
//  Copyright © 2016 maxime marinel. All rights reserved.
//

import UIKit

public struct WeatherResult {
    
    public let city:City
    public let temp:Float?
    public let pressure:Int?
    public let humidity:Int?
    public let temp_min:Float?
    public let temp_max:Float?
    public let sea_level:Float?
    public let grnd_level:Float?
    
    init(city:City, main:NSDictionary) {
        self.city = city
        temp = main["temp"] as? Float
        pressure = main["pressure"] as? Int
        humidity = main["humidity"] as? Int
        temp_min = main["temp_min"] as? Float
        temp_max = main["temp_max"] as? Float
        sea_level = main["sea_level"] as? Float
        grnd_level = main["grnd_level"] as? Float
    }
}
