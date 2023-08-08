//
//  HomeInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import Foundation

final class HomeInteractor {
    
    weak var output: HomeInteractorOutput?
    
    private var areas = [Area]()
    private var latestMeals = [Meal]()
    private var popularMeals = [Meal]()
    private var categories = [Category]()
    
    private let mealRepository: MealRepositoryProtocol
    
    init(mealRepository: MealRepositoryProtocol) {
        self.mealRepository = mealRepository
    }
    
}

// MARK: - HomeInteractorInput

extension HomeInteractor: HomeInteractorInput {
    
    func getAreaName(at index: Int) -> String {
        areas[index].name
    }
    
    func getCategoryName(at index: Int) -> String {
        categories[index].name
    }
    
    func getLatestMealId(at index: Int) -> String {
        latestMeals[index].id
    }
    
    func getPopularMealId(at index: Int) -> String {
        popularMeals[index].id
    }
    
    func retrieveAreaList() {
        mealRepository.loadAreaList { result in
            switch result {
            case .success(let areas):
                self.areas = areas
                self.output?.didRetrieveAreas(areas)
            case .failure(let error):
                self.output?.onError(message: error.description)
            }
        }
    }
    
    func retrieveCategories() {
        mealRepository.loadCategoryList { result in
            switch result {
            case .success(let categories):
                self.categories = categories
                self.output?.didRetrieveCategories(categories)
            case .failure(let error):
                self.output?.onError(message: error.description)
            }
        }
    }
    
    func retrieveLatestMealList() {
        mealRepository.loadMealList(.latestMeals) { result in
            switch result {
            case .success(let meals):
                self.latestMeals = meals
                self.output?.didRetrieveLatestMeals(meals)
            case .failure(let error):
                self.output?.onError(message: error.description)
            }
        }
    }
    
    func retrievePopularMealList() {
        mealRepository.loadMealList(.popularMeals) { result in
            switch result {
            case .success(let meals):
                self.popularMeals = meals
                self.output?.didRetrievePopularMeals(meals)
            case .failure(let error):
                self.output?.onError(message: error.description)
            }
        }
    }
    
}
