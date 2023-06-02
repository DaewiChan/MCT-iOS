//
//  APIEndPoint.swift
//  MCT
//
//  Created by Daewi on 6/1/23.
//

import Foundation
import Alamofire

protocol Endpoint {
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var parameters: [String: Any]? { get }
  
}

extension Endpoint {
//    var baseURLString: String {
//        return "http://54.169.219.68:8080/"
//    }
    // a default extension that creates the full URL
    var url: String {
        return baseURLString + path
    }
}

extension Dictionary where Key == String, Value == Any {
    func toHTTPHeaders() -> HTTPHeaders {
        HTTPHeaders(mapValues { String(describing: $0) })
    }
}

struct BlogEndPoints {
    
}
