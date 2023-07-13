//
//  MealDetailViewInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Foundation

protocol MealDetailViewInput: AnyObject, LoadingDisplayable {
    func refreshList()
    
    func showRecipeText()
    func showIngredientList()
    func showWatchVideoButton()
    
    func applyFavoriteAppearance()
    func resetFavoriteAppearance()
    
    func updateRecipeText(_ text: String?)
    func updateMealName(_ title: String?)
    func updateMealImage(imageUrl: String)
}
