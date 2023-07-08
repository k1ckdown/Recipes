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

extension HomeInteractor: HomeInteractorInput {
    
    func getAreaList(completion: @escaping (Result<[Area], NetworkError>) -> Void) {
        mealRepository.loadAreaList(completion: completion)
    }
    
    func getIngredients(completion: @escaping (Result<[Ingredient], NetworkError>) -> Void) {
        mealRepository.loadIngredientList(completion: completion)
    }
    
    func getMeal(_ type: MealAPI, completion: @escaping (Result<Meal, NetworkError>) -> Void) {
        mealRepository.loadMeal(type, completion: completion)
    }
    
    func getMealList(_ type: MealAPI, completion: @escaping (Result<[Meal], NetworkError>) -> Void) {
        mealRepository.loadMealList(type, completion: completion)
    }
    
}
