//
//  CitiesResponse.swift
//  TestApp
//
//  Created by Tharindu Ketipearachchi on 11/27/17.
//  Copyright © 2017 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper

class CitiesResponse: APIModel {
    
    var cities: [City]?
    
    override func mapping(map: Map) {
        cities <- map["cities"]
    }

}
