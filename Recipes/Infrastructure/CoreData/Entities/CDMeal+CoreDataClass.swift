//
//  CDMeal+CoreDataClass.swift
//  Recipes
//
//  Created by Ivan Semenov on 12.07.2023.
//
//

import Foundation
import CoreData

@objc(CDMeal)
public class CDMeal: NSManagedObject {

}

extension CDMeal {
    
    func toMeal() -> Meal {
        var mealIngredients = [MealIngredient]()
        if let cdMealIngredients = ingredients.allObjects as? [CDMealIngredient]  {
            mealIngredients = cdMealIngredients.map {
                .init(measure: $0.measure, ingredient: $0.ingredient, thumbnailLink: $0.thumbnailLink)
            }
        }
        
        return .init(id: id,
                     name: name,
                     category: category,
                     area: area,
                     instructions: instructions,
                     thumbnailLink: thumbnailLink,
                     youtubeLink: youtubeLink,
                     tags: tags,
                     ingredients: mealIngredients,
                     isFavorite: isFavorite)
    }
    
}
