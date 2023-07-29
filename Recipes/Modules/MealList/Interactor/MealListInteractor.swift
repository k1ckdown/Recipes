//
//  MealListInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

final class MealListInteractor {
    
    weak var output: MealListInteractorOutput?
    
    private let listType: MealListType
    private let mealRepository: MealRepositoryProtocol
    
    init(mealRepository: MealRepositoryProtocol, listType: MealListType) {
        self.listType = listType
        self.mealRepository = mealRepository
    }
    
}

// MARK: - MealListInteractorInput

extension MealListInteractor: MealListInteractorInput {
    
    func getFilterName() -> String {
        switch listType {
        case .byArea(let area):
            return area
        case .byCategory(let category):
            return category
        }
    }
    
    func getMealList(completion: @escaping (Result<[Meal], NetworkError>) -> Void) {
        let mealApi: MealAPI
        
        switch listType {
        case .byArea(let area):
            mealApi = .mealsByArea(area: area)
        case .byCategory(let category):
            mealApi = .mealsByCategory(category: category)
        }
        
        mealRepository.loadMealList(mealApi, completion: completion)
    }
    
}
