//
//  HomeSection.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import Foundation

enum HomeSection: Int, CaseIterable {
    case countries
    case latestMeals
    case ingredients
    case randomMeals
    
    var header: String? {
        switch self {
        case .countries:
            return "Browse Country"
        case .latestMeals:
            return "Latest Meals"
        case .ingredients:
            return "Ingredients"
        case .randomMeals:
            return "Random Meals"
        }
    }
}
