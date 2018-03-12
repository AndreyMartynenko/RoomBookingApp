//
//  Room.swift
//  RoomBookingApp
//
//  Created by Andrey on 3/11/18.
//

import Foundation

struct Room: Decodable {
    
    let name: String?
    let location: String?
    let equipment: [String]?
    let size: String?
    let capacity: Int?
    let avail: [String]?
    let images: [String]?
    
}
