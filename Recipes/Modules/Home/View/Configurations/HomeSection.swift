//
//  HomeSection.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import Foundation

enum HomeSection: Int, CaseIterable {
    case latestMeals
    case ingredients
    case areas
    case randomMeals
    
    var header: String? {
        switch self {
        case .areas:
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
