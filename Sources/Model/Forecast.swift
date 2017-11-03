//
//  Forecast.swift
//  OpenWeatherKit
//
//  Created by maxime marinel on 03/11/2017.
//  Copyright © 2017 OpenWeatherKit. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    struct City: Codable {
        let id: Int
        let name: String
        let country: String
        let coord: Coord
    }
    let city: City
    struct List: Codable {
        let clouds: Clouds
        let main: Main
        let weather: [WeatherData]
        let wind: Wind
    }

    let list: [List]
}
