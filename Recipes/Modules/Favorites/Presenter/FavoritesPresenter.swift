//
//  FavoritesPresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import Foundation

final class FavoritesPresenter {
    
    private(set) var sceneTitle = "Favorites"
    private(set) var introTitle = "You don't have favorites"
    private(set) var mealCellModels = [MealCellModel]() {
        didSet {
            updateIntro()
        }
    }
    
    private weak var view: FavoritesViewInput?
    private let interactor: FavoritesInteractorInput
    private let router: FavoritesRouterInput
    
    init(
        view: FavoritesViewInput,
        interactor: FavoritesInteractorInput,
        router: FavoritesRouterInput
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - FavoritesViewOutput

extension FavoritesPresenter: FavoritesViewOutput {
    
    func viewWillAppear() {
        interactor.retrieveFavoriteMeals()
    }
    
    func numberOfRows() -> Int {
        mealCellModels.count
    }
    
    func didTapOnLogIn() {
        router.showLogInScene()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        router.showMealDetail(mealId: interactor.getMealId(at: indexPath.row))
    }
    
    func removeFavoriteMeal(at index: Int) {
        interactor.deleteFavoriteMeal(at: index)
    }
    
}

// MARK: - FavoritesInteractorOutput

extension FavoritesPresenter: FavoritesInteractorOutput {
    
    func loginFailure() {
        view?.hideContent()
    }
    
    func onError(message: String) {
        router.presentErrorAlert(with: message)
    }
    
    func didRemoveMealFromFavorites(at index: Int) {
        mealCellModels.remove(at: index)
    }
    
    func didRetrieveFavoriteMeals(_ meals: [Meal]) {
        view?.showContent()
        updateMealCellModels(meals)
    }
    
}

// MARK: - Private methods

private extension FavoritesPresenter {
    
    func updateIntro() {
        mealCellModels.count == 0 ? view?.showIntro() : view?.hideIntro()
    }
    
    func updateMealCellModels(_ meals: [Meal]) {
        mealCellModels = meals.map {
            .init(mealName: $0.name,
                  areaName: $0.area ?? "N/A",
                  imageUrl: $0.thumbnailLink,
                  categoryName: $0.category ?? "N/A")
        }
        view?.refreshList()
    }
    
}
