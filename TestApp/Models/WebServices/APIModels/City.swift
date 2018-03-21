//
//  City.swift
//  TestApp
//
//  Created by Tharindu Ketipearachchi on 11/27/17.
//  Copyright © 2017 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class Cityy: APIModel {
    
    var name: String?
    var imageUrl: String?
    var coordinates: Coordinate?
    
    override func mapping(map: Map) {
        name <- map["name"]
        imageUrl <- map["imageUrl"]
        coordinates <- map["coordinates"]
}
}
