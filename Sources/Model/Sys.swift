//
//  Sys.swift
//  OpenWeatherKit
//
//  Created by maxime marinel on 03/11/2017.
//  Copyright © 2017 OpenWeatherKit. All rights reserved.
//

import Foundation

public struct Sys: Codable {
    public let id: Int?
    public let type: Int?
    public let message: Double?
    public let country: String?
    public let sunrise: Int?
    public let sunset: Int?
}
