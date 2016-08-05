//
//  Weather.swift
//  openweather-swift
//
//  Created by maxime marinel on 21/07/2016.
//  Copyright © 2016 maxime marinel. All rights reserved.
//

import UIKit

public struct Weather {
    
    public let temp:Float?
    public let pressure:Int?
    public let humidity:Int?
    public let temp_min:Float?
    public let temp_max:Float?
    public let sea_level:Float?
    public let grnd_level:Float?
    public let icon:Icon
    
    public enum Icon {
        case ClearSky
        case FewClouds
        case ScatteredClouds
        case BrokenClouds
        case ShowerRain
        case Rain
        case Thunderstorm
        case Snow
        case Mist
        case Undefined
    }
    
    public init(main:NSDictionary, weather:NSArray) {
        self.temp = main["temp"] as? Float
        self.pressure = main["pressure"] as? Int
        self.humidity = main["humidity"] as? Int
        self.temp_min = main["temp_min"] as? Float
        self.temp_max = main["temp_max"] as? Float
        self.sea_level = main["sea_level"] as? Float
        self.grnd_level = main["grnd_level"] as? Float
        
        switch (weather.firstObject as! NSDictionary)["icon"] as! String {
        case "01n", "01d":
            icon = .ClearSky
            break
        case "02n", "02d":
            icon = .FewClouds
            break
        case "03n", "03d":
            icon = .ScatteredClouds
            break
        case "04n", "04d":
            icon = .BrokenClouds
            break
        case "09n", "09d":
            icon = .ShowerRain
            break
        case "10n", "10d":
            icon = .Rain
            break
        case "11n", "11d":
            icon = .Thunderstorm
            break
        case "13n", "13d":
            icon = .Snow
            break
        case "50n", "50d":
            icon = .Mist
            break
        default:
            icon = .Undefined
            break
        }
    }
}
