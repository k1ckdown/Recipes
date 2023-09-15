//
//  CreateRecipeInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.09.2023.
//

import Foundation

final class CreateRecipeInteractor {
    
    weak var output: CreateRecipeInteractorOutput?
    private let mealRepository: MealRepositoryProtocol
    
    init(mealRepository: MealRepositoryProtocol) {
        self.mealRepository = mealRepository
    }
    
}

// MARK: - CreateRecipeInteractorInput

extension CreateRecipeInteractor: CreateRecipeInteractorInput {
    
    func retrieveIngredients() {
        mealRepository.loadIngredientList { result in
            switch result {
            case .success(let ingredients):
                self.output?.didRetrieveIngredients(ingredients[0...10].map {
                    .init(measure: "N/A", ingredient: $0.name, thumbnailLink: $0.thumbnailLink)
                })
            case .failure(let error):
                self.output?.onError(message: error.description)
            }
        }
    }
    
}
