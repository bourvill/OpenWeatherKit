//
//  City.swift
//  openweather-swift
//
//  Created by maxime marinel on 21/07/2016.
//  Copyright © 2016 maxime marinel. All rights reserved.
//

import UIKit
import CoreLocation

public struct City {
    
    public let id:Int
    public let name:String
    public let coord:CLLocation
    
    init(id:Int, name:String, coord:NSDictionary) {
        self.id = id
        self.name = name
        self.coord = CLLocation(latitude: coord["lat"] as! Double, longitude: coord["lon"] as! Double)
    }
}
