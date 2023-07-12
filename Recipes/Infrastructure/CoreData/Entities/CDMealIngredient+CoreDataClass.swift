//
//  CDMealIngredient+CoreDataClass.swift
//  Recipes
//
//  Created by Ivan Semenov on 12.07.2023.
//
//

import Foundation
import CoreData

@objc(CDMealIngredient)
public class CDMealIngredient: NSManagedObject {

}

extension CDMealIngredient {
    
    func toMealIngredient() -> MealIngredient {
        .init(measure: measure,
              ingredient: ingredient,
              thumbnailLink: thumbnailLink)
    }
    
}
