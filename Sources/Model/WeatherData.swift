//
//  WeatherData.swift
//  OpenWeatherKit
//
//  Created by maxime marinel on 03/11/2017.
//  Copyright © 2017 OpenWeatherKit. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
