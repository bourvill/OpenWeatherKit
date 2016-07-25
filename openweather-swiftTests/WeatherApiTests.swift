//
//  openweather_swiftTests.swift
//  openweather-swiftTests
//
//  Created by maxime marinel on 20/07/2016.
//  Copyright © 2016 maxime marinel. All rights reserved.
//

import XCTest

@testable import OpenWeatherKit

class WeatherApiTests: XCTestCase {
    
    var client:WeatherApi!
    
    override func setUp() {
        super.setUp()
        client = WeatherApi(apiKey: "ea42045886608526507915df6b33b290")
    }
    
    func testInit() {
        XCTAssertEqual(client.apiKey, "ea42045886608526507915df6b33b290")
    }
    
}
