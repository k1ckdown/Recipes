//
//  MealRepository.swift
//  Recipes
//
//  Created by Ivan Semenov on 06.07.2023.
//

import Foundation

final class MealRepository {
    
    private var favoriteMeals = [Meal]()
    
    private let networkManager: NetworkManager
    private let authService: AuthServiceProtocol
    
    private let localDataSource: MealLocalDataSourceProtocol
    private let remoteDataSource: MealRemoteDataSourceProtocol
    
    init(
        networkManager: NetworkManager,
        localDataSource: MealLocalDataSourceProtocol,
        remoteDataSource: MealRemoteDataSourceProtocol,
        authService: AuthServiceProtocol
    ) {
        self.networkManager = networkManager
        self.localDataSource = localDataSource
        self.authService = authService
        self.remoteDataSource = remoteDataSource
        
        fetchMealList()
    }
    
}

extension MealRepository: MealRepositoryProtocol {
    
    func updateFavoriteMeals() {
        guard let uid = authService.getUserId() else { return }
        fetchRemoteMealList(uid)
    }
    
    func getFavoriteMealList() throws -> [Meal] {
        guard authService.userIsSignedIn() else {
            throw MealRepositoryError.needToLogIn
        }
        return favoriteMeals
    }
    
    func removeFavoriteMeal(_ meal: Meal) throws {
        guard
            NetworkMonitor.shared.isConnected,
            let uid = authService.getUserId()
        else {
            throw MealRepositoryError.noInternet
        }
        
        favoriteMeals.removeAll(where: { $0 == meal })
        localDataSource.deleteMeal(meal)
        remoteDataSource.deleteMeal(meal, uid: uid)
    }
    
    func putFavoriteMeal(_ meal: Meal) throws {
        guard NetworkMonitor.shared.isConnected else {
            throw MealRepositoryError.noInternet
        }
        
        guard let uid = authService.getUserId() else {
            throw MealRepositoryError.needToLogIn
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
                var meal = favoriteMeals.first(where: { $0.id == id })
            else { fallthrough }
            meal.isFavorite = true
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

// MARK: - Private methods

private extension MealRepository {
    
    func fetchMealList() {
        guard let uid = authService.getUserId() else { return }
        NetworkMonitor.shared.isConnected ? fetchRemoteMealList(uid) : fetchLocalMealList(uid)
    }
    
    func fetchLocalMealList(_ uid: String) {
        localDataSource.getMealList(uid) { result in
            switch result {
            case .success(let mealList):
                self.favoriteMeals = mealList
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchRemoteMealList(_ uid: String) {
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
