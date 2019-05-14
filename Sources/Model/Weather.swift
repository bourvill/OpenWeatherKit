//
//  Weather.swift
//  OpenWeatherKit
//
//  Created by maxime marinel on 03/11/2017.
//  Copyright © 2017 OpenWeatherKit. All rights reserved.
//

import Foundation

public struct Weather: Codable {
    public let id: Int
    public let visibility: Int?
    public let name: String?
    public let coord: Coord?
    public let wind: Wind?
    public let base: String?
    public let dt: Int?
    public let weather: [WeatherData]?
    public let sys: Sys?
    public let clouds: Clouds?
    public let main: Main?
}
