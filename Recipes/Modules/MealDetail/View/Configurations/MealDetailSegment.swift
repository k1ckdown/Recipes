//
//  MealDetailSegment.swift
//  Recipes
//
//  Created by Ivan Semenov on 08.07.2023.
//

import Foundation

enum MealDetailSegment: Int, CaseIterable {
    case ingredients
    case recipe
    
    var title: String {
        switch self {
        case .ingredients:
            return "Ingredients"
        case .recipe:
            return "Recipe"
        }
    }
}
