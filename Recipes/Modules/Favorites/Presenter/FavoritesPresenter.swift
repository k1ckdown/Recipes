//
//  FavoritesPresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import Foundation

final class FavoritesPresenter {
    
    private weak var view: FavoritesViewInput?
    private let interactor: FavoritesInteractorInput
    private let router: FavoritesRouterInput
    
    private(set) var sceneTitle = "Favorites"
    private(set) var mealCellModels = [MealCellModel]()
    private var favoriteMeals = [Meal]()
    
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
        if interactor.userIsSignedIn() {
            view?.showContent()
            favoriteMeals = interactor.getFavoriteMeals()
            updateIntro()
            updateMealCellModels()
        } else {
            view?.hideContent()
        }
        
        
    }
    
    func introTitle() -> String {
        "You don't have favorites"
    }
    
    func numberOfRows() -> Int {
        mealCellModels.count
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        router.showMealDetail(mealId: favoriteMeals[indexPath.row].id)
    }
    
    func removeFavoriteMeal(at index: Int) {
        interactor.deleteFavoriteMeal(favoriteMeals[index])
        favoriteMeals.remove(at: index)
        mealCellModels.remove(at: index)
        updateIntro()
    }
    
    func didTapOnLogIn() {
        router.showLogInScene()
    }
    
}

// MARK: - FavoritesInteractorOutput

extension FavoritesPresenter: FavoritesInteractorOutput {
    
}

private extension FavoritesPresenter {
    
    func updateIntro() {
        favoriteMeals.count == 0 ? view?.showIntro() : view?.hideIntro()
    }
    
    func updateMealCellModels() {
        mealCellModels = favoriteMeals.map {
            .init(mealName: $0.name,
                  areaName: $0.area ?? "N/A",
                  imageUrl: $0.thumbnailLink,
                  categoryName: $0.category ?? "N/A")
        }
        view?.refreshList()
    }
}
