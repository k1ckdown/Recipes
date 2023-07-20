//
//  MealDetailInteractorInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Foundation

protocol MealDetailInteractorInput: AnyObject {
    func addFavoriteMeal(_ meal: Meal, completion: (MealRepositoryError?) -> Void)
    func deleteFavoriteMeal(_ meal: Meal, completion: (MealRepositoryError?) -> Void)
    func getMeal(completion: @escaping (Result<Meal, NetworkError>) -> Void)
}
