
//
//  APIClient.swift
//  TestApp
//
//  Created by Tharindu Ketipearachchi on 11/25/17.
//  Copyright © 2017 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SwiftyJSON

class APIClient: NSObject {
    
    enum APIResponseStatus : Int {
        case Success = 200
        case SuccessAlso = 201
        case ValidationError = 422
        case Error = 212
        case CommonError = 213
        case BadRequest = 400
        case UnAuthorized = 403
        case NotFound = 404
        case InternalServerError = 500
        case Other
    }
    
    private let apiKey = "825iosDev"
    
    func getHTTPHeaders() -> HTTPHeaders? {
        return [ "api-key" : apiKey];
    }

}

extension APIClient {
    func getUserList (url:URL, params:[String : Any?], completion:@escaping (APIResponseStatus, UserListResponse) -> Void)  {
        let request = Alamofire.request(url,
                                        method: .get,
                                        parameters: params ,
                                        encoding: JSONEncoding.default,
                                        headers: self.getHTTPHeaders())

        request.responseObject{ (response:DataResponse<UserListResponse>) in
           
            completion(APIClient.APIResponseStatus(rawValue: (response.response?.statusCode)!)!, response.result.value!)
        }
    }
    
    func getCities (url:URL, params:[String : Any?], completion:@escaping (APIResponseStatus, CitiesResponse) -> Void)  {
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        parameters: params ,
                                        encoding: JSONEncoding.default,
                                        headers: self.getHTTPHeaders())
//            request.responseJSON { response in
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization
//
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                }
//        }

        
        request.responseObject{ (response:DataResponse<CitiesResponse>) in

            completion(APIClient.APIResponseStatus(rawValue: (response.response?.statusCode)!)!, response.result.value!)
        }
    }
    
    func register (url:URL, params:[String : Any?], completion:@escaping (APIResponseStatus, RegisterResponse) -> Void)  {
        let request = Alamofire.request(url,
                                        method: .post,
                                        parameters: params ,
                                        encoding: JSONEncoding.default,
                                        headers: self.getHTTPHeaders())
        
        request.responseObject{ (response:DataResponse<RegisterResponse>) in
            
            completion(APIClient.APIResponseStatus(rawValue: (response.response?.statusCode)!)!, response.result.value!)
        }
    }
}
