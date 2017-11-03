//
//  Sys.swift
//  OpenWeatherKit
//
//  Created by maxime marinel on 03/11/2017.
//  Copyright © 2017 OpenWeatherKit. All rights reserved.
//

import Foundation

struct Sys: Codable {
    let id: Int
    let type: Int
    let message: Double
    let country: String
    let sunrise: Int
    let sunset: Int
}
