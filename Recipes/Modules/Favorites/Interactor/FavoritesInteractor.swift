//
//  FavoritesInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import Foundation

final class FavoritesInteractor {
    
    weak var output: FavoritesInteractorOutput?
    
    private var favoriteMeals = [Meal]()
    private let authService: AuthServiceProtocol
    private let mealRepository: MealRepositoryProtocol
    
    init(mealRepository: MealRepositoryProtocol, authService: AuthServiceProtocol) {
        self.authService = authService
        self.mealRepository = mealRepository
    }
}

// MARK: - FavoritesViewInput

extension FavoritesInteractor: FavoritesInteractorInput {
    
    func getMealId(at index: Int) -> String {
        favoriteMeals[index].id
    }
    
    func deleteFavoriteMeal(at index: Int) {
        do {
            try mealRepository.removeFavoriteMeal(favoriteMeals[index])
            favoriteMeals.remove(at: index)
            output?.didRemoveMealFromFavorites(at: index)
        } catch {
            if let error = error as? MealRepositoryError {
                output?.onError(message: error.description)
            }
        }
    }
    
    func retrieveFavoriteMeals() {
        do {
            favoriteMeals = try mealRepository.getFavoriteMealList()
            output?.didRetrieveFavoriteMeals(favoriteMeals)
        } catch let error as MealRepositoryError {
            if case .needToLogIn = error {
                output?.loginFailure()
            }
        } catch {
            output?.onError(message: error.localizedDescription)
        }
    }
    
}
