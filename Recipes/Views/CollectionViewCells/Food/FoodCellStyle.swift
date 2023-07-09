//
//  FoodCellStyle.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit

enum FoodCellStyle {
    case latestMeal
    case category
    case defaultMeal

    var font: UIFont {
        switch self {
        case .latestMeal, .defaultMeal:
            return .mealNameTitle
        case .category:
            return .ingredientNameTitle
        }
    }
    
    var shouldShowName: Bool {
        switch self {
        case .latestMeal:
            return true
        case .category:
            return true
        case .defaultMeal:
            return true
        }
    }
    
    var cornerRadius: CGFloat {
        switch self {
        case .category:
            return 10
        case .latestMeal, .defaultMeal:
            return 0
        }
    }
    
    var imageHeightMultiplier: CGFloat {
        switch self {
        case .latestMeal:
            return 1
        case .category, .defaultMeal:
            return 0.7
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .category:
            return .appGray
        case .latestMeal, .defaultMeal:
            return .clear
        }
    }
    
    var labelBackgroundColor: UIColor? {
        switch self {
        case .latestMeal:
            return .appBackground?.withAlphaComponent(0.9)
        case .category:
            return .clear
        case .defaultMeal:
            return .clear
        }
    }
}
