//
//  WeatherData.swift
//  OpenWeatherKit
//
//  Created by maxime marinel on 03/11/2017.
//  Copyright © 2017 OpenWeatherKit. All rights reserved.
//

import Foundation

public struct WeatherData: Codable {
    public let id: Int?
    public let main: String?
    public let description: String?
    public let icon: String?
}
