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
        favoriteMeals = interactor.getFavoriteMeals()
        print(favoriteMeals)
    }
    
}

// MARK: - FavoritesInteractorOutput

extension FavoritesPresenter: FavoritesInteractorOutput {
    
}
