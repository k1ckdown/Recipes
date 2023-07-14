//
//  AuthError.swift
//  Recipes
//
//  Created by Ivan Semenov on 15.07.2023.
//

import Foundation

enum AuthError: Error {
    case invalidEmail
    case userNotFound
    case tooManyRequests
    case wrongPassword
    case weakPassword
    case networkError
    case requestFailed
    
    var description: String {
        switch self {
        case .invalidEmail:
            return "WARNING: Invalid Email"
        case .userNotFound:
            return "WARNING: User not found"
        case .tooManyRequests:
            return "WARNING: Too many requests"
        case .wrongPassword:
            return "WARNING: Wrong password"
        case .weakPassword:
            return "WARNING: Weak password"
        case .networkError:
            return "WARNING: Network error"
        case .requestFailed:
            return "Request failed. Please, try again later."
        }
    }
    
}
