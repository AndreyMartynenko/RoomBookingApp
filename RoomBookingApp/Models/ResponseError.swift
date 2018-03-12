//
//  ResponseError.swift
//  RoomBookingApp
//
//  Created by Andrey on 3/11/18.
//

import Foundation

struct ResponseError: Decodable {
    struct Error: Decodable {
        let code: Int?
        let text: String?
    }
    
    let error: Error?
}
