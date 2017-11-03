//
//  Stub.swift
//  OpenWeatherKit
//
//  Created by maxime marinel on 03/11/2017.
//  Copyright © 2017 OpenWeatherKit. All rights reserved.
//

import Foundation
@testable import OpenWeatherKit

class Task: URLSessionDataTask {
    var resumeCall = false
    override func resume() {
        resumeCall = true
    }
}

class MockURLSession: URLSessionProtocol {
    private (set) var lastURL: URL?
    var nextDataTask = Task()
    var nextData: Data?
    var nextError: Error?
    var lastMethod: String = "GET"
    var lastBody: Data?

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
        lastURL = url
        completionHandler(nextData, nil, nextError)
        return nextDataTask
    }

    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        lastURL = request.url!
        lastMethod = request.httpMethod!
        lastBody = request.httpBody
        completionHandler(nextData, nil, nextError)
        return nextDataTask
    }
}
