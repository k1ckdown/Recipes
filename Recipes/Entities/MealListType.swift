//
//  MealListType.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

enum MealListType {
    case byArea(area: String)
    case byCategory(category: String)
    
    var name: String {
        switch self {
        case .byArea(let area):
            return area
        case .byCategory(let category):
            return category
        }
    }
}
