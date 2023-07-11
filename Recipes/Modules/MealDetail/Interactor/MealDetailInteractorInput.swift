//
//  MealDetailInteractorInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Foundation

protocol MealDetailInteractorInput: AnyObject {
    func addFavoriteMeal(_ meal: Meal)
    func deleteFavoriteMeal(_ meal: Meal)
    func getMeal(completion: @escaping (Result<Meal, NetworkError>) -> Void)
}
