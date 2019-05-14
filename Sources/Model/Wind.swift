//
//  Wind.swift
//  OpenWeatherKit
//
//  Created by maxime marinel on 03/11/2017.
//  Copyright © 2017 OpenWeatherKit. All rights reserved.
//

import Foundation

public struct Wind: Codable {
    public let speed: Double?
    public let deg: Double?

    public var degString: String {
        get {
            if 0 == deg || 360 == deg {
                return "N"
            } else if 45 == deg {
                return "NE"
            } else if 90 == deg {
                return "E"
            } else if 135 == deg {
                return "SE"
            } else if 180 == deg {
                return "S"
            } else if 270 == deg {
                return "W"
            }

            return "N"
        }
    }
}
