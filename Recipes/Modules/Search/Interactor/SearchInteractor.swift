//
//  SearchInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

final class SearchInteractor {
    
    weak var output: SearchInteractorOutput?
    
    private var meals = [Meal]()
    private let mealRepository: MealRepositoryProtocol

    init(mealRepository: MealRepositoryProtocol) {
        self.mealRepository = mealRepository
    }
    
}

// MARK: - SearchInteractorInput

extension SearchInteractor: SearchInteractorInput {
    
    func getMealId(at index: Int) -> String {
        meals[index].id
    }
    
    func retrieveRandomMeals() {
        mealRepository.loadMealList(.randomMeals) { result in
            switch result {
            case .success(let meals):
                self.meals = meals
                self.output?.didRetrieveRandomMeals(meals)
            case .failure(let error):
                self.output?.onError(message: error.description)
            }
        }
    }
    
    func retrieveMealListByName(_ name: String) {
        mealRepository.loadMealList(.mealsByName(name: name)) { result in
            switch result {
            case .success(let meals):
                self.meals = meals
                self.output?.didRetrieveMealListByName(meals)
            case .failure(let error):
                self.output?.onError(message: error.description)
            }
        }
    }
    
}
