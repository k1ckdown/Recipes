//
//  FavoritesInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import Foundation

final class FavoritesInteractor {
    
    weak var output: FavoritesInteractorOutput?
    
    private let authService: AuthServiceProtocol
    private let mealRepository: MealRepositoryProtocol
    
    init(mealRepository: MealRepositoryProtocol, authService: AuthServiceProtocol) {
        self.authService = authService
        self.mealRepository = mealRepository
    }
}

// MARK: - FavoritesViewInput

extension FavoritesInteractor: FavoritesInteractorInput {
    
    func userIsSignedIn() -> Bool {
        authService.userIsSignedIn()
    }
    
    func getFavoriteMeals() -> [Meal] {
        mealRepository.getFavoriteMealList()
    }
    
    func deleteFavoriteMeal(_ meal: Meal, completion: (MealRepositoryError?) -> Void) {
        mealRepository.removeFavoriteMeal(meal, completion: completion)
    }
    
}
