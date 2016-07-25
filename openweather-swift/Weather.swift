//
//  Weather.swift
//  openweather-swift
//
//  Created by maxime marinel on 21/07/2016.
//  Copyright © 2016 maxime marinel. All rights reserved.
//

import UIKit

public struct Weather {
    
    public let temp:Float
    public let pressure:Int
    public let humidity:Int
    public let temp_min:Float
    public let temp_max:Float
    public let sea_level:Float
    public let grnd_level:Float
    
    public init(fromForecast:NSDictionary) {
        self.temp = fromForecast["temp"] as! Float
        self.pressure = fromForecast["pressure"] as! Int
        self.humidity = fromForecast["humidity"] as! Int
        self.temp_min = fromForecast["temp_min"] as! Float
        self.temp_max = fromForecast["temp_max"] as! Float
        self.sea_level = fromForecast["sea_level"] as! Float
        self.grnd_level = fromForecast["grnd_level"] as! Float
    }
}
