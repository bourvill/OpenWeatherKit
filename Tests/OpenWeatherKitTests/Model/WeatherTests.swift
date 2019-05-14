//
//  WeatherTests.swift
//  OpenWeatherKit
//
//  Created by maxime marinel on 03/11/2017.
//  Copyright © 2017 OpenWeatherKit. All rights reserved.
//

import Foundation
import XCTest
@testable import OpenWeatherKit

class WeatherTests: XCTestCase {
    func testDecode() {
              let path = Bundle(for: type(of: self)).path(forResource: "weather", ofType: "json")
        let data = try! String(contentsOfFile: path!).data(using: .utf8)!
        let decoder = JSONDecoder()

        let weather = try! decoder.decode(Weather.self, from: data)

        XCTAssertEqual(3028486, weather.id)
        XCTAssertEqual(10000, weather.visibility)
        XCTAssertEqual("Carvin", weather.name)
        XCTAssertEqual("stations", weather.base)
        XCTAssertEqual(1508842800, weather.dt)

        //Clouds
        XCTAssertEqual(90, weather.clouds?.all)
        //sys
        XCTAssertEqual(1, weather.sys?.type)
        XCTAssertEqual(5625, weather.sys?.id)
        XCTAssertEqual(0.0044, weather.sys?.message)
        XCTAssertEqual("FR", weather.sys?.country)
        XCTAssertEqual(1508826388, weather.sys?.sunrise)
        XCTAssertEqual(1508863034, weather.sys?.sunset)
        //Coord
        XCTAssertEqual(50.49, weather.coord?.lat)
        XCTAssertEqual(2.96, weather.coord?.lon)
        //Wind
        XCTAssertEqual(5.7, weather.wind?.speed)
        XCTAssertEqual(220, weather.wind?.deg)
        //Main
        XCTAssertEqual(289.61, weather.main?.temp)
        XCTAssertEqual(1021, weather.main?.pressure)
        XCTAssertEqual(88, weather.main?.humidity)
        XCTAssertEqual(288.15, weather.main?.tempMin)
        XCTAssertEqual(290.15, weather.main?.tempMax)
        //Weather
        let weatherData = weather.weather!.first!
        XCTAssertEqual(804, weatherData.id)
        XCTAssertEqual("Clouds", weatherData.main)
        XCTAssertEqual("overcast clouds", weatherData.description)
        XCTAssertEqual("04d", weatherData.icon)
    }
}
