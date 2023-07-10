//
//  SearchInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

final class SearchInteractor {
    
    weak var output: SearchInteractorOutput?
    
    private let mealRepository: MealRepository

    init(mealRepository: MealRepository) {
        self.mealRepository = mealRepository
    }
    
}

// MARK: - SearchInteractorInput

extension SearchInteractor: SearchInteractorInput {

    func getRandomMealList(completion: @escaping (Result<[Meal], NetworkError>) -> Void) {
        mealRepository.loadMealList(.randomMeals, completion: completion)
    }
    
    func getMealListByName(_ name: String, completion: @escaping (Result<[Meal], NetworkError>) -> Void) {
        mealRepository.loadMealList(.mealsByName(name: name), completion: completion)
    }
    
}
