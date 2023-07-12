//
//  FavoritesInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import Foundation

final class FavoritesInteractor {
    
    weak var output: FavoritesInteractorOutput?
    
    private let mealRepository: MealRepository
    
    init(mealRepository: MealRepository) {
        self.mealRepository = mealRepository
    }
}

// MARK: - FavoritesViewInput

extension FavoritesInteractor: FavoritesInteractorInput {
    func getFavoriteMeals() -> [Meal] {
        mealRepository.getFavoriteMealList()
    }
    
    func deleteFavoriteMeal(_ meal: Meal) {
        mealRepository.removeFavoriteMeal(meal)
    }
}
