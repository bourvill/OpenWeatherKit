//
//  Main.swift
//  OpenWeatherKit
//
//  Created by maxime marinel on 03/11/2017.
//  Copyright © 2017 OpenWeatherKit. All rights reserved.
//

import Foundation

public struct Main: Codable {
    public let temp: Double?
    public let pressure: Double?
    public let humidity: Int?
    public let tempMin: Double?
    public let tempMax: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}
