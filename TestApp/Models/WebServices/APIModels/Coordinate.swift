//
//  Coordinate.swift
//  TestApp
//
//  Created by Tharindu Ketipearachchi on 11/27/17.
//  Copyright © 2017 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class Coordinate: APIModel {
    
    var longitude: Double?
    var latitude: Double?
    
    override func mapping(map: Map) {
        longitude <- map["longitude"]
        latitude <- map["latitude"]
    }

}
