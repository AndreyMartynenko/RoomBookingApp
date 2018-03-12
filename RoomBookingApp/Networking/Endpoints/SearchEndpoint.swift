//
//  SearchEndpoint.swift
//  RoomBookingApp
//
//  Created by Andrey on 3/11/18.
//

import Foundation

struct SearchEndpoint: Endpoint {
    
    var base: String {
        return "https://challenges.1aim.com"
    }
    
    var path: String {
        return "/roombooking_app/getrooms"
    }
    
    var httpMethod: HttpMethod {
        return .post
    }
    
}
