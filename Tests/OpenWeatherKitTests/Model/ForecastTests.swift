//
//  ForecastTests.swift
//  OpenWeatherKit
//
//  Created by maxime marinel on 03/11/2017.
//  Copyright © 2017 OpenWeatherKit. All rights reserved.
//

import Foundation
import XCTest
@testable import OpenWeatherKit

class ForecastTests: XCTestCase {
    func testDecode() {
        let path = Bundle(for: type(of: self)).path(forResource: "forecast", ofType: "json")
        let data = try! String(contentsOfFile: path!).data(using: .utf8)!
        let decoder = JSONDecoder()

        let forecast = try! decoder.decode(Forecast.self, from: data)

        //city
        XCTAssertEqual(3028486, forecast.city.id)
        XCTAssertEqual("Carvin", forecast.city.name)
        XCTAssertEqual("FR", forecast.city.country)
        XCTAssertEqual(50.4924, forecast.city.coord.lat)
        XCTAssertEqual(2.9582, forecast.city.coord.lon)
        XCTAssertEqual(40, forecast.list.count)

        let firstList = forecast.list.first!
        XCTAssertEqual(8, firstList.clouds.all)

        //wind
        XCTAssertEqual(3.75, firstList.wind.speed)
        XCTAssertEqual(281.502, firstList.wind.deg)

        //weatherlist
        let firstWeather = firstList.weather.first!
        XCTAssertEqual(800, firstWeather.id)
        XCTAssertEqual("Clear", firstWeather.main)
        XCTAssertEqual("ciel dégagé", firstWeather.description)
        XCTAssertEqual("02n", firstWeather.icon)
        //main
        XCTAssertEqual(6.92, firstList.main.temp)
        XCTAssertEqual(1038.85, firstList.main.pressure)
        XCTAssertEqual(93, firstList.main.humidity)
        XCTAssertEqual(6.92, firstList.main.tempMin)
        XCTAssertEqual(7.12, firstList.main.tempMax)
    }
}
