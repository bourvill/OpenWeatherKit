//
//  Weather.swift
//  OpenWeatherKit
//
//  Created by maxime marinel on 03/11/2017.
//  Copyright © 2017 OpenWeatherKit. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let visibility: Int
    let name: String
    let coord: Coord
    let wind: Wind
    let base: String
    let dt: Int
    let weather: [WeatherData]
    let sys: Sys
    let clouds: Clouds
    let main: Main
}
