//
//  MealLocalDataSource.swift
//  Recipes
//
//  Created by Ivan Semenov on 12.07.2023.
//

import Foundation
import CoreData

final class MealLocalDataSource {
    
    static let shared = MealLocalDataSource()
    
    private let context: NSManagedObjectContext
    private var cdMeals = [CDMeal]()
    
    private init() {
        self.context = CoreDataManager.shared.context
    }
    
    func save(_ meal: Meal) {
        let cdMeal = CDMeal(context: context)
        cdMeal.id = meal.id
        cdMeal.area = meal.area
        cdMeal.category = meal.category
        cdMeal.instructions = meal.instructions
        cdMeal.isFavorite = meal.isFavorite
        cdMeal.name = meal.name
        cdMeal.tags = meal.tags
        cdMeal.thumbnailLink = meal.thumbnailLink
        cdMeal.youtubeLink = meal.youtubeLink
        cdMeal.ingredients = NSSet(array: meal.ingredients.map { mealIngredient in
            let cdIngredient = CDMealIngredient(context: context)
            
            cdIngredient.measure = mealIngredient.measure
            cdIngredient.ingredient = mealIngredient.ingredient
            cdIngredient.thumbnailLink = mealIngredient.thumbnailLink
            
            return cdIngredient
        })
        cdMeals.append(cdMeal)
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func delete(_ meal: Meal) {
        guard let cdMeal = cdMeals.first(where: { $0.id == meal.id }) else { return }
        context.delete(cdMeal)
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func fetchMealList(completion: (Result<[Meal], Error>) -> Void) {
        let request: NSFetchRequest<CDMeal> = .init(entityName: "CDMeal")
        
        do {
            let mealList = try context.fetch(request)
            self.cdMeals = mealList
            completion(.success(mealList.map { $0.toMeal() }))
        } catch {
            print(error)
        }
    }
    
}
