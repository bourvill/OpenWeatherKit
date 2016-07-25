//
//  WeatherApi.swift
//  weather
//
//  Created by maxime marinel on 27/05/2016.
//  Copyright © 2016 maxime marinel. All rights reserved.
//

import UIKit

public class WeatherApi {
    
    public enum Result {
        case Success(NSURLResponse!, NSDictionary!)
        case Error(NSURLResponse!, NSError!)
        
        public func data() -> NSDictionary? {
            switch self {
            case .Success(_, let dictionary):
                return dictionary
            case .Error(_, _):
                return nil
            }
        }
        
        public func response() -> NSURLResponse? {
            switch self {
            case .Success(let response, _):
                return response
            case .Error(let response, _):
                return response
            }
        }
        
        public func error() -> NSError? {
            switch self {
            case .Success(_, _):
                return nil
            case .Error(_, let error):
                return error
            }
        }
    }
    
    private struct Const {
        static let basePath = "http://api.openweathermap.org/data/"
        static let apiVersion = "2.5"
    }
    
    public var apiKey:String
    
    public init(apiKey:String) {
        self.apiKey = apiKey
    }
    
    public func currentWeather(latitude:String, longitude:String, callback: (WeatherResult?) -> ()) {
        send("weather", param:"lat=\(latitude)&lon=\(longitude)") { result in
            guard let data = result.data() else {
                callback(nil)
                return
            }
            callback(WeatherResult(city:City(id: data["id"] as! Int, name: data["name"] as! String, coord: data["coord"] as! NSDictionary), main: data["main"] as! NSDictionary))
        }
    }
    
    public func currentWeather(cityId: Int, callback: (WeatherResult?) -> ()) {
        send("weather", param:"id=\(cityId)") { result in
            guard let data = result.data() else {
                callback(nil)
                return
            }
            callback(WeatherResult(city:City(id: data["id"] as! Int, name: data["name"] as! String, coord: data["coord"] as! NSDictionary), main: data["main"] as! NSDictionary))
        }
    }
    
    public func dailyForecast(latitude:String, longitude:String, callback: (ForecastResult?) -> ()) {
        send("forecast", param:"lat=\(latitude)&lon=\(longitude)") { result in
            switch result {
            case .Success:
                callback(ForecastResult(data: result.data()!))
                break;
            case .Error:
                callback(nil)
                break;
            }
        }
    }
    
    public func dailyForecast(cityId: Int, callback: (Result) -> ()) {
        // send("/forecast/daily?id=\(cityId)", callback: callback)
    }
    
    private func send(endpoint:String, param:String, callback: (Result) -> ())
    {
        let currentQueue = NSOperationQueue.currentQueue()
        
        let urlString:String = Const.basePath + Const.apiVersion + "/" + endpoint + "?APPID=" + apiKey + "&lang=fr&units=metric&" + param
        let url:NSURL = NSURL(string: urlString)!
        let request:NSURLRequest = NSURLRequest(URL: url)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
            var error: NSError? = error
            var dictionary: NSDictionary?
            if let data = data {
                do {
                    dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? NSDictionary
                } catch let e as NSError {
                    error = e
                }
                
                currentQueue?.addOperationWithBlock {
                    var result = Result.Success(response, dictionary)
                    if error != nil {
                        result = Result.Error(response, error)
                    }
                    callback(result)
                }
            }
        }
        task.resume()
    }
}
