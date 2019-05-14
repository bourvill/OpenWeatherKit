//
//  WeatherApiTests.swift
//  OpenWeatherKit
//
//  Created by maxime marinel on 03/11/2017.
//  Copyright © 2017 OpenWeatherKit. All rights reserved.
//

import Foundation
import XCTest
@testable import OpenWeatherKit

class WeatherApiTests: XCTestCase {

    func testInit() {
        let weatherApi = WeatherApi(key: "keytest")
        XCTAssertEqual("keytest", weatherApi.key)
        XCTAssertEqual("2.5", weatherApi.version)
        XCTAssertEqual("https://api.openweathermap.org/data", weatherApi.endpoint)
    }

    func testGetEndpoint() {
        let weatherApi = WeatherApi(key: "keytest")
        XCTAssertEqual("https://api.openweathermap.org/data/2.5/", weatherApi.getEndpoint())
    }

    func testDefaultParametersAddAPPID() {
        let weatherApi = WeatherApi(key: "keytest")

        XCTAssertEqual(1, weatherApi.defaultParameters.count)

        let queryItem = weatherApi.defaultParameters.first!
        XCTAssertEqual("APPID", queryItem.name)
        XCTAssertEqual("keytest", queryItem.value)
    }

    func testAddDefaultParameter() {
        let weatherApi = WeatherApi(key: "keytest")

        XCTAssertEqual(1, weatherApi.defaultParameters.count)

        weatherApi.addDefaultParameter(name: "lang", value: "FR")
        XCTAssertEqual(2, weatherApi.defaultParameters.count)

        let queryItem = weatherApi.defaultParameters.first!
        XCTAssertEqual("APPID", queryItem.name)
        XCTAssertEqual("keytest", queryItem.value)

        let secondItem = weatherApi.defaultParameters[1]
        XCTAssertEqual("lang", secondItem.name)
        XCTAssertEqual("FR", secondItem.value)
    }

    func testGetWeatherForLatLonSuccess() {
        let mockSession = MockURLSession()
        let dataTask = Task()
        mockSession.nextDataTask = dataTask

        let path = Bundle(for: type(of: self)).path(forResource: "weather", ofType: "json")
        mockSession.nextData = try! String(contentsOfFile: path!).data(using: .utf8)

        let weatherApi = WeatherApi(key: "keytest", urlSession: mockSession)

        let expect = expectation(description: "Get completion")
        weatherApi.getWeatherFor(lat: "5.567788", lon: "1.5544") { result in
            expect.fulfill()

            switch result {
            case .success(let results):
                XCTAssertEqual(3028486, results.id)
                XCTAssertTrue(true)
            case .error(_):
                XCTFail()
            }
        }

        // Additional params are not guaranteed in order as they are passed in a dict
        XCTAssert(
            mockSession.lastURL?.absoluteString == "https://api.openweathermap.org/data/2.5/weather?APPID=keytest&lat=5.567788&lon=1.5544" ||
            mockSession.lastURL?.absoluteString == "https://api.openweathermap.org/data/2.5/weather?APPID=keytest&lon=1.5544&lat=5.567788")
        XCTAssertTrue(dataTask.resumeCall)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetWeatherForLatLonErrorWithEmptydData() {
        let mockSession = MockURLSession()
        let dataTask = Task()
        mockSession.nextDataTask = dataTask

        let weatherApi = WeatherApi(key: "keytest", urlSession: mockSession)

        let expect = expectation(description: "Get completion")
        weatherApi.getWeatherFor(lat: "5.567788", lon: "1.5544") { result in
            expect.fulfill()

            switch result {
            case .success(_):
                XCTFail()
            case .error(let error):
                guard let error = error else {
                    XCTFail()
                    return
                }
                XCTAssertEqual("invalidData", "\(error)")
            }
        }

        XCTAssertEqual(mockSession.lastURL?.absoluteString, "https://api.openweathermap.org/data/2.5/weather?APPID=keytest&lat=5.567788&lon=1.5544")
        XCTAssertTrue(dataTask.resumeCall)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetWeatherForLatLonErrorWithInvalidJSON() {
        let mockSession = MockURLSession()
        let dataTask = Task()
        mockSession.nextDataTask = dataTask
        mockSession.nextData = "[]".data(using: .utf8)

        let weatherApi = WeatherApi(key: "keytest", urlSession: mockSession)

        let expect = expectation(description: "Get completion")
        weatherApi.getWeatherFor(lat: "5.567788", lon: "1.5544") { result in
            expect.fulfill()

            switch result {
            case .success(_):
                XCTFail()
            case .error(let error):
                guard let error = error else {
                    XCTFail()
                    return
                }
                XCTAssertEqual("typeMismatch(Swift.Dictionary<Swift.String, Any>, Swift.DecodingError.Context(codingPath: [], debugDescription: \"Expected to decode Dictionary<String, Any> but found an array instead.\", underlyingError: nil))", "\(error)")
            }
        }

        // Additional params are not guaranteed in order as they are passed in a dict
        XCTAssert(
            mockSession.lastURL?.absoluteString == "https://api.openweathermap.org/data/2.5/weather?APPID=keytest&lat=5.567788&lon=1.5544" ||
                mockSession.lastURL?.absoluteString == "https://api.openweathermap.org/data/2.5/weather?APPID=keytest&lon=1.5544&lat=5.567788")
        XCTAssertTrue(dataTask.resumeCall)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetWeatherForIdSuccess() {
        let mockSession = MockURLSession()
        let dataTask = Task()
        mockSession.nextDataTask = dataTask

        let path = Bundle(for: type(of: self)).path(forResource: "weather", ofType: "json")
        mockSession.nextData = try! String(contentsOfFile: path!).data(using: .utf8)

        let weatherApi = WeatherApi(key: "keytest", urlSession: mockSession)

        let expect = expectation(description: "Get completion")
        weatherApi.getWeatherFor(cityId: 3028486) { result in
            expect.fulfill()

            switch result {
            case .success(let results):
                XCTAssertEqual(3028486, results.id)
                XCTAssertTrue(true)
            case .error(_):
                XCTFail()
            }
        }

        XCTAssertEqual(mockSession.lastURL?.absoluteString, "https://api.openweathermap.org/data/2.5/weather?APPID=keytest&id=3028486")
        XCTAssertTrue(dataTask.resumeCall)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetForecastForLatLonSuccess() {
        let mockSession = MockURLSession()
        let dataTask = Task()
        mockSession.nextDataTask = dataTask

        let path = Bundle(for: type(of: self)).path(forResource: "forecast", ofType: "json")
        mockSession.nextData = try! String(contentsOfFile: path!).data(using: .utf8)

        let weatherApi = WeatherApi(key: "keytest", urlSession: mockSession)

        let expect = expectation(description: "Get completion")
        weatherApi.getForecastFor(lat: "5.567788", lon: "1.5544") { result in
            expect.fulfill()

            switch result {
            case .success(let forecast):
                XCTAssertEqual("Carvin", forecast.city.name)
                XCTAssertTrue(true)
            case .error(_):
                XCTFail()
            }
        }

        // Additional params are not guaranteed in order as they are passed in a dict
        XCTAssert(
            mockSession.lastURL?.absoluteString == "https://api.openweathermap.org/data/2.5/forecast?APPID=keytest&lat=5.567788&lon=1.5544" ||
                mockSession.lastURL?.absoluteString == "https://api.openweathermap.org/data/2.5/forecast?APPID=keytest&lon=1.5544&lat=5.567788")
        XCTAssertTrue(dataTask.resumeCall)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetForecastForLatLonErrorWithEmptydData() {
        let mockSession = MockURLSession()
        let dataTask = Task()
        mockSession.nextDataTask = dataTask

        let weatherApi = WeatherApi(key: "keytest", urlSession: mockSession)

        let expect = expectation(description: "Get completion")
        weatherApi.getForecastFor(lat: "5.567788", lon: "1.5544") { result in
            expect.fulfill()

            switch result {
            case .success(_):
                XCTFail()
            case .error(let error):
                guard let error = error else {
                    XCTFail()
                    return
                }
                XCTAssertEqual("invalidData", "\(error)")
            }
        }

        // Additional params are not guaranteed in order as they are passed in a dict
        XCTAssert(
            mockSession.lastURL?.absoluteString == "https://api.openweathermap.org/data/2.5/forecast?APPID=keytest&lat=5.567788&lon=1.5544" ||
                mockSession.lastURL?.absoluteString == "https://api.openweathermap.org/data/2.5/forecast?APPID=keytest&lon=1.5544&lat=5.567788")
        XCTAssertTrue(dataTask.resumeCall)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetForecastForLatLonErrorWithInvalidJSON() {
        let mockSession = MockURLSession()
        let dataTask = Task()
        mockSession.nextDataTask = dataTask
        mockSession.nextData = "[]".data(using: .utf8)

        let weatherApi = WeatherApi(key: "keytest", urlSession: mockSession)

        let expect = expectation(description: "Get completion")
        weatherApi.getForecastFor(lat: "5.567788", lon: "1.5544") { result in
            expect.fulfill()

            switch result {
            case .success(_):
                XCTFail()
            case .error(let error):
                guard let error = error else {
                    XCTFail()
                    return
                }
                XCTAssertEqual("typeMismatch(Swift.Dictionary<Swift.String, Any>, Swift.DecodingError.Context(codingPath: [], debugDescription: \"Expected to decode Dictionary<String, Any> but found an array instead.\", underlyingError: nil))", "\(error)")
            }
        }

        // Additional params are not guaranteed in order as they are passed in a dict
        XCTAssert(
            mockSession.lastURL?.absoluteString == "https://api.openweathermap.org/data/2.5/forecast?APPID=keytest&lat=5.567788&lon=1.5544" ||
                mockSession.lastURL?.absoluteString == "https://api.openweathermap.org/data/2.5/forecast?APPID=keytest&lon=1.5544&lat=5.567788")
        XCTAssertTrue(dataTask.resumeCall)
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetForecastForIdSuccess() {
        let mockSession = MockURLSession()
        let dataTask = Task()
        mockSession.nextDataTask = dataTask

        let path = Bundle(for: type(of: self)).path(forResource: "forecast", ofType: "json")
        mockSession.nextData = try! String(contentsOfFile: path!).data(using: .utf8)

        let weatherApi = WeatherApi(key: "keytest", urlSession: mockSession)

        let expect = expectation(description: "Get completion")
        weatherApi.getForecastFor(cityId: 43) { result in
            expect.fulfill()

            switch result {
            case .success(let forecast):
                XCTAssertEqual("Carvin", forecast.city.name)
                XCTAssertTrue(true)
            case .error(_):
                XCTFail()
            }
        }

        XCTAssertEqual(mockSession.lastURL?.absoluteString, "https://api.openweathermap.org/data/2.5/forecast?APPID=keytest&id=43")
        XCTAssertTrue(dataTask.resumeCall)
        waitForExpectations(timeout: 5, handler: nil)
    }
}
