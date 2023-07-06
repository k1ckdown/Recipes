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
    case popularMeal

    var font: UIFont {
        switch self {
        case .latestMeal, .popularMeal:
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
        case .popularMeal:
            return true
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .latestMeal:
            return .appBackground?.withAlphaComponent(0.9)
        case .ingredient:
            return .clear
        case .popularMeal:
            return .clear
        }
    }
    
    var imageHeightMultiplier: CGFloat {
        switch self {
        case .latestMeal:
            return 1
        case .ingredient, .popularMeal:
            return 0.7
        }
    }
}
