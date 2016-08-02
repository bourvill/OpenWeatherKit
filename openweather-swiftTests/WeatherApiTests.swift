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
    
    override func setUp() {
        super.setUp()
        WeatherApi.setApplication(apiKey: "ea42045886608526507915df6b33b290")
    }
    
    func testInit() {
        XCTAssertEqual(WeatherApi.Const.basePath, "http://api.openweathermap.org/data/")
        XCTAssertEqual(WeatherApi.Const.apiVersion, "2.5")
        XCTAssertEqual(WeatherApi.apiKey, "ea42045886608526507915df6b33b290")
    }
}
