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
    
    func getMealList(completion: @escaping (Result<[Meal], NetworkError>) -> Void) {
    }
    
}
