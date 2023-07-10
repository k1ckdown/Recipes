//
//  HomeInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import Foundation

final class HomeInteractor {
    
    weak var output: HomeInteractorOutput?
    
    private let mealRepository: MealRepository
    
    init(mealRepository: MealRepository) {
        self.mealRepository = mealRepository
    }
    
}

// MARK: - HomeInteractorInput

extension HomeInteractor: HomeInteractorInput {
    
    func getAreaList(completion: @escaping (Result<[Area], NetworkError>) -> Void) {
        mealRepository.loadAreaList(completion: completion)
    }
    
    func getCategories(completion: @escaping (Result<[Category], NetworkError>) -> Void) {
        mealRepository.loadCategoryList(completion: completion)
    }
    
    func getMeal(_ type: MealAPI, completion: @escaping (Result<Meal, NetworkError>) -> Void) {
        mealRepository.loadMeal(type, completion: completion)
    }
    
    func getPopularMealList(completion: @escaping (Result<[Meal], NetworkError>) -> Void) {
        mealRepository.loadMealList(.popularMeals, completion: completion)
    }
    
    func getLatestMealList(completion: @escaping (Result<[Meal], NetworkError>) -> Void) {
        mealRepository.loadMealList(.latestMeals, completion: completion)
    }

}
