//
//  MealListInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

final class MealListInteractor {
    
    weak var output: MealListInteractorOutput?
    
    private var meals = [Meal]()
    private let listType: MealListType
    private let mealRepository: MealRepositoryProtocol
    
    init(mealRepository: MealRepositoryProtocol, listType: MealListType) {
        self.listType = listType
        self.mealRepository = mealRepository
    }
    
}

// MARK: - MealListInteractorInput

extension MealListInteractor: MealListInteractorInput {
    
    func getMealId(at index: Int) -> String {
        meals[index].id
    }
    
    func retrieveMeals() {
        let mealApi: MealAPI
        
        switch listType {
        case .byArea(let area):
            mealApi = .mealsByArea(area: area)
        case .byCategory(let category):
            mealApi = .mealsByCategory(category: category)
        }
        
        mealRepository.loadMealList(mealApi) { result in
            switch result {
            case .success(let meals):
                self.meals = meals
                self.output?.didRetrieveMeals(meals, filterName: self.listType.name)
            case .failure(let error):
                self.output?.onError(message: error.description)
            }
        }
    }
    
}
