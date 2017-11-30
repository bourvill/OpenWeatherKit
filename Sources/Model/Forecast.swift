//
//  Forecast.swift
//  OpenWeatherKit
//
//  Created by maxime marinel on 03/11/2017.
//  Copyright © 2017 OpenWeatherKit. All rights reserved.
//

import Foundation

public struct Forecast: Codable {
    public struct City: Codable {
        public let id: Int
        public let name: String
        public let country: String
        public let coord: Coord
    }
    public let city: City

    public struct List: Codable {
        public let dt: Int
        public let clouds: Clouds
        public let main: Main
        public let weather: [WeatherData]
        public let wind: Wind
    }
    public let list: [List]
}
