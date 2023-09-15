//
//  CreateRecipeInteractorOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.09.2023.
//

import Foundation

protocol CreateRecipeInteractorOutput: AnyObject {
    func onError(message: String)
    func didRetrieveIngredients(_ ingredients: [MealIngredient])
}
