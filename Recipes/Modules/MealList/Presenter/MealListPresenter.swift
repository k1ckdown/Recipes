//
//  MealListPresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

final class MealListPresenter {
    
    private(set) var mealCellModels = [FoodCellModel]()
    
    private weak var view: MealListViewInput?
    private let interactor: MealListInteractorInput
    private let router: MealListRouterInput
    
    init(
        view: MealListViewInput,
        interactor: MealListInteractorInput,
        router: MealListRouterInput
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - MealListViewOutput

extension MealListPresenter: MealListViewOutput {
    
    func viewDidLoad() {
        interactor.retrieveMeals()
    }
    
    func numberOfItems() -> Int {
        mealCellModels.count
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        router.showMealDetail(mealId: interactor.getMealId(at: indexPath.item))
    }
    
}

// MARK: - MealListInteractorOutput

extension MealListPresenter: MealListInteractorOutput {
    
    func onError(message: String) {
        router.presentErrorAlert(with: message)
    }
    
    func didRetrieveMeals(_ meals: [Meal], filterName: String) {
        updateMealCellModels(meals)
        view?.updateNavigationTitle(filterName)
    }
    
}

// MARK: - Private methods

private extension MealListPresenter {
    
    func updateMealCellModels(_ meals: [Meal]) {
        mealCellModels = meals.map {
            .init(
                foodName: $0.name,
                imageUrl: $0.thumbnailLink,
                foodType: .defaultMeal)
        }
        view?.refreshList()
    }
    
}
