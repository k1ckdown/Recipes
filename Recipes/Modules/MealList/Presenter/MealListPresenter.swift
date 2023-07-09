//
//  MealListPresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

final class MealListPresenter {
    
    private weak var view: MealListViewInput?
    private let interactor: MealListInteractorInput
    private let router: MealListRouterInput
    
    private(set) var mealCellModels = [FoodCellModel]()
    
    private var meals = [Meal]() {
        didSet {
            mealCellModels = meals.map {
                .init(
                    foodName: $0.name,
                    imageUrl: $0.thumbnailLink,
                    foodType: .defaultMeal)
            }
           updateView()
        }
    }
    
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

// MARK: -

extension MealListPresenter: MealListViewOutput {
    
    func viewDidLoad() {
        fetchMeals()
    }
    
    func numberOfItems() -> Int {
        mealCellModels.count
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        router.showMealDetail(mealId: meals[indexPath.item].id)
    }
    
}

// MARK: - MealListInteractorOutput

extension MealListPresenter: MealListInteractorOutput {
    
}

private extension MealListPresenter {
    
    func updateView() {
        view?.refreshList()
        view?.updateNavigationTitle(interactor.getFilterName())
    }
    
    func fetchMeals() {
        interactor.getMealList { result in
            switch result {
            case .success(let meals):
                self.meals = meals
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
}
