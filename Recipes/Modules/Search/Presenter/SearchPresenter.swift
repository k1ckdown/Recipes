//
//  SearchPresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

final class SearchPresenter {
    
    private(set) var sceneTitle = "Search"
    private(set) var searchPlaceholder = "Recipes"
    private(set) var mealCellModels = [MealCellModel]()
    
    private weak var view: SearchViewInput?
    private let interactor: SearchInteractorInput
    private let router: SearchRouterInput
    
    init(
        view: SearchViewInput,
        interactor: SearchInteractorInput,
        router: SearchRouterInput
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - SearchViewOutput

extension SearchPresenter: SearchViewOutput {
    
    func numberOfItems() -> Int {
        mealCellModels.count
    }
    
    func viewDidLoad() {
        view?.showLoader()
        interactor.retrieveRandomMeals()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        router.showMealDetail(mealId: interactor.getMealId(at: indexPath.row))
    }
    
    func didPerformSearch(_ value: String?) {
        guard let value = value else { return }
        interactor.retrieveMealListByName(value)
    }
    
}

// MARK: - SearchInteractorOutput

extension SearchPresenter: SearchInteractorOutput {
    
    func onError(message: String) {
        router.presentErrorAlert(with: message)
    }
    
    func didRetrieveRandomMeals(_ meals: [Meal]) {
        updateMealCellModels(meals)
    }
    
    func didRetrieveMealListByName(_ meals: [Meal]) {
        updateMealCellModels(meals)
    }
    
}

// MARK: - Private methods

private extension SearchPresenter {
    
    func updateMealCellModels(_ meals: [Meal]) {
        mealCellModels = meals.map {
            .init(mealName: $0.name,
                  areaName: $0.area ?? "N/A",
                  imageUrl: $0.thumbnailLink,
                  categoryName: $0.category ?? "N/A")
        }
        view?.hideLoader()
        view?.refreshList()
    }
    
}
