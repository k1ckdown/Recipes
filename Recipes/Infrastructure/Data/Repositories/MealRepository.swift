//
//  MealRepository.swift
//  Recipes
//
//  Created by Ivan Semenov on 06.07.2023.
//

import Foundation

final class MealRepository {
    
    private var favoriteMeals = [Meal]()
    
    private let authService: AuthService
    private let networkManager: NetworkManager
    
    private let localDataSource: MealLocalDataSource
    private let remoteDataSource: MealRemoteDataSource
    
    init(
        networkManager: NetworkManager,
        mealDataSource: MealLocalDataSource,
        authService: AuthService
    ) {
        self.networkManager = networkManager
        self.localDataSource = mealDataSource
        self.authService = authService
        remoteDataSource = .init()
        
        fetchMealList()
    }
    
    func updateFavoriteMeals() {
        fetchRemoteMealList()
    }
    
    func getFavoriteMealList() -> [Meal] {
        favoriteMeals
    }
    
    func removeFavoriteMeal(_ meal: Meal, completion: (MealRepositoryError?) -> Void) {
        guard
            NetworkMonitor.shared.isConnected,
            let uid = authService.getUserId()
        else {
            completion(.noInternet)
            return
        }
        
        favoriteMeals.removeAll(where: { $0 == meal })
        localDataSource.deleteMeal(meal)
        remoteDataSource.deleteMeal(meal, uid: uid)
    }
    
    func putFavoriteMeal(_ meal: Meal, completion: (MealRepositoryError?) -> Void) {
        guard
            NetworkMonitor.shared.isConnected,
            let uid = authService.getUserId(),
            !favoriteMeals.contains(meal)
        else {
            completion(.noInternet)
            return
        }
        
        favoriteMeals.append(meal)
        localDataSource.saveMeal(meal, uid: uid)
        remoteDataSource.saveMeal(meal, uid: uid)
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
    
    func loadMeal(_ type: MealAPI, completion: @escaping (Result<Meal, NetworkError>) -> Void) {
        switch type {
        case .mealById(let id):
            guard
                !NetworkMonitor.shared.isConnected,
                let meal = favoriteMeals.first(where: { $0.id == id })
            else { fallthrough }
            completion(.success(meal))
            
        default:
            networkManager.fetchMealData(mealEndPoint: type) {
                (result: Result<MealListResponse, NetworkError>) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let value):
                        if var meal = value.meals.first?.toMeal() {
                            meal.isFavorite = self.favoriteMeals.contains(meal)
                            completion(.success(meal))
                        } else {
                            completion(.failure(.requestFailed))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
}

private extension MealRepository {
    
    func fetchMealList() {
        NetworkMonitor.shared.isConnected ? fetchRemoteMealList() : fetchLocalMealList()
    }
    
    func fetchLocalMealList() {
        guard let uid = authService.getUserId() else { return }
        
        localDataSource.getMealList(uid) { result in
            switch result {
            case .success(let mealList):
                self.favoriteMeals = mealList
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchRemoteMealList() {
        guard let uid = authService.getUserId() else { return }
        
        remoteDataSource.fetchMeal(uid) { result in
            switch result {
            case .success(let meals):
                self.favoriteMeals = meals
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
