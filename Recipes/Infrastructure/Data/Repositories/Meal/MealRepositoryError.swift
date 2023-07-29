//
//  MealRepositoryError.swift
//  Recipes
//
//  Created by Ivan Semenov on 20.07.2023.
//

import Foundation

enum MealRepositoryError: Error {
    case noInternet
    case needToLogIn
    
    var description: String {
        switch self {
        case .noInternet:
            return "No internet connection"
        case .needToLogIn:
            return "You need to log in"
        }
    }
}
