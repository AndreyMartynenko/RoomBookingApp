//
//  SearchClient.swift
//  RoomBookingApp
//
//  Created by Andrey on 3/11/18.
//

import Foundation

class SearchClient: NetworkClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func retrieveRooms(with parameters: Any?, completion: @escaping (Result<[Room]?, NetworkError>) -> Void) {
        var request = SearchEndpoint().request
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        fetch(with: request, decode: { json -> [Room]? in
            guard let rooms = json as? [Room] else { return nil }
            return rooms
        }, completion: completion)
    }
    
}
