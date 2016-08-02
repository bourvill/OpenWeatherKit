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
    
    func testCurrentWeatherByName() {
        let expectation = expectationWithDescription("currentWeatherByName")
        WeatherApi.currentWeather("Lille FR") { result in
            XCTAssertNotNil(result)
            XCTAssertEqual(result!.city.name, "Lille")
            XCTAssertEqual(result!.city.coord.coordinate.latitude,  50.63000000)
            XCTAssertEqual(result!.city.coord.coordinate.longitude,  3.07000000)
            XCTAssertNotNil(result!.temp)
            XCTAssertNotNil(result!.pressure)
            XCTAssertNotNil(result!.humidity)
            XCTAssertNotNil(result!.temp_max)
            XCTAssertNotNil(result!.temp_min)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testCurrentWeatherById() {
        let expectation = expectationWithDescription("currentWeatherByName")
        WeatherApi.currentWeather(6454414) { result in
            XCTAssertNotNil(result)
            XCTAssertEqual(result!.city.name, "Lille")
            XCTAssertEqual(result!.city.coord.coordinate.latitude,  50.63000000)
            XCTAssertEqual(result!.city.coord.coordinate.longitude,  3.07000000)
            XCTAssertNotNil(result!.temp)
            XCTAssertNotNil(result!.pressure)
            XCTAssertNotNil(result!.humidity)
            XCTAssertNotNil(result!.temp_max)
            XCTAssertNotNil(result!.temp_min)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testCurrentWeatherByLocation() {
        let expectation = expectationWithDescription("currentWeatherByName")
        WeatherApi.currentWeather("50.63000000", longitude: "3.07000000") { result in
            XCTAssertNotNil(result)
            XCTAssertEqual(result!.city.name, "Lille")
            XCTAssertEqual(result!.city.coord.coordinate.latitude,  50.63000000)
            XCTAssertEqual(result!.city.coord.coordinate.longitude,  3.07000000)
            XCTAssertNotNil(result!.temp)
            XCTAssertNotNil(result!.pressure)
            XCTAssertNotNil(result!.humidity)
            XCTAssertNotNil(result!.temp_max)
            XCTAssertNotNil(result!.temp_min)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
}
