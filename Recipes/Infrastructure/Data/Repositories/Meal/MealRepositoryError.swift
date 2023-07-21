//
//  MealRepositoryError.swift
//  Recipes
//
//  Created by Ivan Semenov on 20.07.2023.
//

import Foundation

enum MealRepositoryError: Error {
    case noInternet
    
    var description: String {
        switch self {
        case .noInternet:
            return "No internet connection"
        }
    }
}
