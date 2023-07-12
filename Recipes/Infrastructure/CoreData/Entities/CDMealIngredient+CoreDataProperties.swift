//
//  CDMealIngredient+CoreDataProperties.swift
//  Recipes
//
//  Created by Ivan Semenov on 12.07.2023.
//
//

import Foundation
import CoreData


extension CDMealIngredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMealIngredient> {
        return NSFetchRequest<CDMealIngredient>(entityName: "CDMealIngredient")
    }

    @NSManaged public var ingredient: String
    @NSManaged public var measure: String
    @NSManaged public var thumbnailLink: String

}

extension CDMealIngredient : Identifiable {

}
