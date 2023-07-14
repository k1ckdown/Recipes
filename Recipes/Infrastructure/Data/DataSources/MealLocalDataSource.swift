//
//  MealLocalDataSource.swift
//  Recipes
//
//  Created by Ivan Semenov on 12.07.2023.
//

import Foundation
import CoreData

final class MealLocalDataSource {
    
    private var cdMeals = [CDMeal]()
    private let context: NSManagedObjectContext
    
    init() {
        self.context = CoreDataManager.shared.context
    }
    
    func deleteMeal(_ meal: Meal) {
        guard let cdMealIndex = cdMeals.firstIndex(where: { $0.id == meal.id }) else { return }
        context.delete(cdMeals[cdMealIndex])
        cdMeals.remove(at: cdMealIndex)
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func getMealList(_ uid: String, completion: (Result<[Meal], Error>) -> Void) {
        let request: NSFetchRequest<CDMeal> = .init(entityName: "CDMeal")
        request.predicate = NSPredicate(format: "uid == %@", uid)
        
        do {
            let mealList = try context.fetch(request)
            self.cdMeals = mealList
            completion(.success(mealList.map { $0.toMeal() }))
        } catch {
            print(error)
        }
    }
    
    func saveMeal(_ meal: Meal, uid: String) {
        let cdMeal = CDMeal(context: context)
        
        cdMeal.uid = uid
        cdMeal.id = meal.id
        cdMeal.name = meal.name
        cdMeal.area = meal.area
        cdMeal.tags = meal.tags
        cdMeal.category = meal.category
        cdMeal.isFavorite = meal.isFavorite
        cdMeal.youtubeLink = meal.youtubeLink
        cdMeal.instructions = meal.instructions
        cdMeal.thumbnailLink = meal.thumbnailLink
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
    
}
