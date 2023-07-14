//
//  MealDetailInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Foundation

final class MealDetailInteractor {
    
    weak var output: MealDetailInteractorOutput?
    
    private let mealId: String
    private let mealRepository: MealRepository
    
    init(mealRepository: MealRepository, mealId: String) {
        self.mealId = mealId
        self.mealRepository = mealRepository
    }
    
}

// MARK: - MealDetailInteractorInput

extension MealDetailInteractor: MealDetailInteractorInput {
    
    func deleteFavoriteMeal(_ meal: Meal) {
        mealRepository.removeFavoriteMeal(meal)
    }
    
    func addFavoriteMeal(_ meal: Meal) {
        mealRepository.putFavoriteMeal(meal)
    }
    
    func getMeal(completion: @escaping (Result<Meal, NetworkError>) -> Void) {
        mealRepository.loadMeal(.mealById(id: mealId), completion: completion)
    }
    
}
