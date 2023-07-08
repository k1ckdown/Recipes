//
//  HomeSection.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import Foundation

enum HomeSection: Int, CaseIterable {
    case latestMeals
    case categories
    case areas
    case popularMeals
    
    var header: String? {
        switch self {
        case .latestMeals:
            return "Latest Meals"
        case .categories:
            return "Categories"
        case .areas:
            return "Browse Country"
        case .popularMeals:
            return "Popular Meals"
        }
    }
}
