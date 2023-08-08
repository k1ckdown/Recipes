//
//  MealDetailInteractorOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Foundation

protocol MealDetailInteractorOutput: AnyObject {
    func onError(message: String)
    
    func didAddMealToFavorites()
    func didRemoveMealFromFavorites()
    func didRetrieveMeal(_ meal: Meal)
}
