//
//  NetworkError.swift
//  Recipes
//
//  Created by Ivan Semenov on 05.07.2023.
//

import Foundation

enum NetworkError: Error {
    case missingURL
    case invalidData
    case requestFailed
    case urlSessionError(String)
    case invalidResponse
    
    var description: String {
        switch self {
        case .missingURL:
            return "URL is nil."
        case .invalidResponse:
            return "Invalid Response"
        case .urlSessionError(let desc):
            return desc
        case .invalidData:
            return "Response returned with no data to decode"
        case .requestFailed:
            return "Request failed. Please, try again later."
        }
    }
}
