//
//  CDMeal+CoreDataProperties.swift
//  Recipes
//
//  Created by Ivan Semenov on 12.07.2023.
//
//

import Foundation
import CoreData


extension CDMeal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMeal> {
        return NSFetchRequest<CDMeal>(entityName: "CDMeal")
    }

    @NSManaged public var isFavorite: Bool
    @NSManaged public var tags: [String]?
    @NSManaged public var youtubeLink: String?
    @NSManaged public var thumbnailLink: String
    @NSManaged public var instructions: String?
    @NSManaged public var area: String?
    @NSManaged public var category: String?
    @NSManaged public var name: String
    @NSManaged public var id: String
    @NSManaged public var ingredients: NSSet

}

// MARK: Generated accessors for ingredients
extension CDMeal {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: CDMealIngredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: CDMealIngredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

extension CDMeal : Identifiable {

}
