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
    public let weather:Weather
    
    init(city:City, main:NSDictionary, weather:NSArray) {
        self.city = city
        self.weather = Weather(main: main, weather: weather)
    }
}
