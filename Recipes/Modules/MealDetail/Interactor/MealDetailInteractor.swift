//
//  MealDetailInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Foundation

final class MealDetailInteractor {
    
    weak var output: MealDetailInteractorOutput?
    
    private var meal: Meal?
    private let mealId: String
    private let mealRepository: MealRepositoryProtocol
    
    init(mealRepository: MealRepositoryProtocol, mealId: String) {
        self.mealId = mealId
        self.mealRepository = mealRepository
    }
    
}

// MARK: - MealDetailInteractorInput

extension MealDetailInteractor: MealDetailInteractorInput {
    
    func toggleFavoriteMealState() {
        guard let meal = meal else { return }
        meal.isFavorite ? removeMealFromFavorites(meal) : addMealToFavorites(meal)
    }
    
    func retrieveMeals() {
        mealRepository.loadMeal(.mealById(id: mealId)) { result in
            switch result {
            case .success(let meal):
                self.meal = meal
                self.output?.didRetrieveMeal(meal)
            case .failure(let error):
                self.output?.onError(message: error.description)
            }
        }
    }
    
}

// MARK: - Private methods

private extension MealDetailInteractor {
    
    func addMealToFavorites(_ meal: Meal) {
        do {
            try mealRepository.putFavoriteMeal(meal)
            self.meal?.isFavorite = true
            output?.didAddMealToFavorites()
        } catch {
            if let error = error as? MealRepositoryError {
                output?.onError(message: error.description)
            }
        }
    }
    
    func removeMealFromFavorites(_ meal: Meal) {
        do {
            try mealRepository.removeFavoriteMeal(meal)
            self.meal?.isFavorite = false
            output?.didRemoveMealFromFavorites()
        } catch {
            if let error = error as? MealRepositoryError {
                output?.onError(message: error.description)
            }
        }
    }
    
}
