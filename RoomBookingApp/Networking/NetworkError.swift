//
//  NetworkError.swift
//  RoomBookingApp
//
//  Created by Andrey on 3/11/18.
//

import Foundation

enum NetworkError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case custom(
        code: Int?,
        description: String?
    )
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .custom(let code, let description): if let code = code, let description = description { return "\(code): \(description)" } else { return "" }
        }
    }
}
