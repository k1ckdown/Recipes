//
//  MealDetailPresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Foundation
import UIKit

final class MealDetailPresenter {
    
    private(set) var watchVideoTitle = "Watch Video"
    private(set) var ingredientCellModels = [IngredientCellModel]()
    
    private var mealYoutubeLink: String?
    private let segmentedItems = MealDetailSegment.allCases
    private let startSelectedSegment = MealDetailSegment.ingredients
    
    private weak var view: MealDetailViewInput?
    private let interactor: MealDetailInteractorInput
    private let router: MealDetailRouterInput
    
    init(
        view: MealDetailViewInput,
        interactor: MealDetailInteractorInput,
        router: MealDetailRouterInput
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - MealDetailViewOutput

extension MealDetailPresenter: MealDetailViewOutput {
    
    func viewDidLoad() {
        view?.showLoader()
        interactor.retrieveMeals()
        selectSegment(startSelectedSegment)
    }
    
    func numberOfItems() -> Int {
        ingredientCellModels.count
    }
    
    func getSegmentedItems() -> [String] {
        segmentedItems.map { $0.title }
    }
    
    func getStartSelectedSegment() -> Int {
        startSelectedSegment.rawValue
    }
    
    func didTapOnFavoriteButton() {
        interactor.toggleFavoriteMealState()
    }
    
    func didSelectSegment(at index: Int) {
        let segment = segmentedItems[index]
        selectSegment(segment)
    }
    
    func didTapOnWatchVideoButton() {
        guard
            let youtubeLink = mealYoutubeLink,
            let url = URL(string: youtubeLink)
        else { return }
        
        router.openUrl(url)
    }
    
}

// MARK: - MealDetailInteractorOutput

extension MealDetailPresenter: MealDetailInteractorOutput {
    
    func onError(message: String) {
        router.presentErrorAlert(with: message)
    }
    
    func didAddMealToFavorites() {
        view?.applyFavoriteAppearance()
    }
    
    func didRemoveMealFromFavorites() {
        view?.resetFavoriteAppearance()
    }
    
    func didRetrieveMeal(_ meal: Meal) {
        updateMealDetail(meal)
        updateIngredientCellModels(meal.ingredients)
        mealYoutubeLink = meal.youtubeLink
    }
}

// MARK: - Private methods

private extension MealDetailPresenter {
    
    func selectSegment(_ segment: MealDetailSegment) {
        switch segment {
        case .ingredients:
            view?.showIngredientList()
        case .recipe:
            view?.showRecipeText()
        }
    }
    
    func updateIngredientCellModels(_ ingredients: [MealIngredient]) {
        ingredientCellModels = ingredients.map {
            .init(
                imageUrl: $0.thumbnailLink,
                nameIngredient: $0.ingredient,
                measure: $0.measure
            )
        }
        view?.refreshList()
    }
    
    func updateMealDetail(_ meal: Meal) {
        view?.hideLoader()
        view?.updateMealName(meal.name)
        view?.updateRecipeText(meal.instructions)
        view?.updateMealImage(imageUrl: meal.thumbnailLink)
        meal.isFavorite ? view?.applyFavoriteAppearance() : view?.resetFavoriteAppearance()
        
        if let youtubeLink = meal.youtubeLink, !youtubeLink.isEmpty {
            view?.showWatchVideoButton()
        }
    }
    
}
