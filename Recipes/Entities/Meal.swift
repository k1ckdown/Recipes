//
//  Meal.swift
//  Recipes
//
//  Created by Ivan Semenov on 06.07.2023.
//

import Foundation

struct Meal: Equatable {
    let id: String
    let name: String
    let category: String?
    let area: String?
    let instructions: String?
    let thumbnailLink: String
    let youtubeLink: String?
    let tags: [String]?
    let ingredients: [MealIngredient]
    var isFavorite = false
    
    static func == (lhs: Meal, rhs: Meal) -> Bool {
        return lhs.id == rhs.id
    }
}

struct MealIngredient {
    let measure: String
    let ingredient: String
    let thumbnailLink: String
}
