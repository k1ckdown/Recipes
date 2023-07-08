//
//  MealRepository.swift
//  Recipes
//
//  Created by Ivan Semenov on 06.07.2023.
//

import Foundation

final class MealRepository {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func loadAreaList(completion: @escaping (Result<[Area], NetworkError>) -> Void) {
        networkManager.fetchMealData(mealEndPoint: .areaList) {
            (result: Result<AreaListResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    completion(.success(value.areas.map { $0.toArea() }))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func loadCategoryList(completion: @escaping (Result<[Category], NetworkError>) -> Void) {
        networkManager.fetchMealData(mealEndPoint: .categories) {
            (result: Result<CategoryListResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    completion(.success(value.categories.map { $0.toCategory() }))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func loadIngredientList(completion: @escaping (Result<[Ingredient], NetworkError>) -> Void) {
        networkManager.fetchMealData(mealEndPoint: .ingredientList) {
            (result: Result<IngredientListResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    completion(.success(value.ingredients.map { $0.toIngredient() }))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func loadMeal(_ type: MealAPI, completion: @escaping (Result<Meal, NetworkError>) -> Void) {
        networkManager.fetchMealData(mealEndPoint: type) {
            (result: Result<MealListResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    if let meal = value.meals.first {
                        completion(.success(meal.toMeal()))
                    } else {
                        completion(.failure(.requestFailed))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func loadMealList(_ type: MealAPI, completion: @escaping (Result<[Meal], NetworkError>) -> Void) {
        networkManager.fetchMealData(mealEndPoint: type) {
            (result: Result<MealListResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    completion(.success(value.meals.map { $0.toMeal() }))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
