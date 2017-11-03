//
//  WindTests.swift
//  OpenWeatherKit
//
//  Created by maxime marinel on 03/11/2017.
//  Copyright © 2017 OpenWeatherKit. All rights reserved.
//

import Foundation
import XCTest
@testable import OpenWeatherKit

class WindTests: XCTestCase {

    func testWind0DegreesNorth() {
        let wind = Wind(speed: 0, deg: 0)
        XCTAssertEqual("N", wind.degString)
    }

    func testWind360DegreesNorth() {
        let wind = Wind(speed: 0, deg: 360)
        XCTAssertEqual("N", wind.degString)
    }

    func testWind180DegreesSouth() {
        let wind = Wind(speed: 0, deg: 180)
        XCTAssertEqual("S", wind.degString)
    }

    func testWind90DegreesEast() {
        let wind = Wind(speed: 0, deg: 90)
        XCTAssertEqual("E", wind.degString)
    }

    func testWind270DegreesWest() {
        let wind = Wind(speed: 0, deg: 270)
        XCTAssertEqual("W", wind.degString)
    }

    func testWind45DegreesNE() {
        let wind = Wind(speed: 0, deg: 45)
        XCTAssertEqual("NE", wind.degString)
    }

    func testWind135DegreesSE() {
        let wind = Wind(speed: 0, deg: 135)
        XCTAssertEqual("SE", wind.degString)
    }
}
