//
//  Endpoint.swift
//  RoomBookingApp
//
//  Created by Andrey on 3/11/18.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol Endpoint {
    
    var base: String { get }
    var path: String { get }
    var httpMethod: HttpMethod { get }
    
}

extension Endpoint {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = String(describing: httpMethod)
        
        return request
    }
}
