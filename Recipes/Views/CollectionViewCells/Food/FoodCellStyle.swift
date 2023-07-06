//
//  FoodCellStyle.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit

enum FoodCellStyle {
    case latestMeal
    case ingredient
    case randomMeal

    var font: UIFont {
        switch self {
        case .latestMeal, .randomMeal:
            return .mealNameTitle
        case .ingredient:
            return .ingredientNameTitle
        }
    }
    
    var shouldShowName: Bool {
        switch self {
        case .latestMeal:
            return true
        case .ingredient:
            return true
        case .randomMeal:
            return true
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .latestMeal:
            return .appBackground?.withAlphaComponent(0.9)
        case .ingredient:
            return .clear
        case .randomMeal:
            return .clear
        }
    }
    
    var imageHeightMultiplier: CGFloat {
        switch self {
        case .latestMeal:
            return 1
        case .ingredient, .randomMeal:
            return 0.7
        }
    }
}
