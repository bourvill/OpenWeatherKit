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
    
    public struct Const {
        static let basePath = "http://api.openweathermap.org/data/"
        static let apiVersion = "2.5"
    }
    
    static var apiKey:String?
    
    public class func setApplication(apiKey apiKey: String) {
        self.apiKey = apiKey
    }
    
    static func send(endpoint:String, param:String, callback: (Result) -> ())
    {
        assert(apiKey != nil, "Error, you must define apiKey")
        
        let currentQueue = NSOperationQueue.currentQueue()!
        
        let urlString:String = Const.basePath + Const.apiVersion + "/" + endpoint + "?APPID=" + self.apiKey! + "&lang=fr&units=metric&" + param.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        
        let url:NSURL = NSURL(string: urlString)!
        
        let request:NSURLRequest = NSURLRequest(URL: url)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
            var error: NSError? = error
            var dictionary: NSDictionary?
            if let data = data {
                do {
                    dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? NSDictionary
                    //Hack : api respond String or Int...
                    if ("\(dictionary!["cod"]!)" != "200") {
                        throw NSError(domain: dictionary!["message"] as! String, code: 404, userInfo: [:])
                    }
                } catch let e as NSError {
                    error = e
                }
                
                currentQueue.addOperationWithBlock {
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