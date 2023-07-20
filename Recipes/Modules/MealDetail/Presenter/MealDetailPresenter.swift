//
//  MealDetailPresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Foundation
import UIKit

final class MealDetailPresenter {
    
    private weak var view: MealDetailViewInput?
    private let interactor: MealDetailInteractorInput
    private let router: MealDetailRouterInput
    
    private(set) var ingredientCellModels = [IngredientCellModel]()
    
    private let segmentedItems = MealDetailSegment.allCases
    private let startSelectedSegment = MealDetailSegment.ingredients
    
    private var meal: Meal? {
        didSet {
            ingredientCellModels = meal?.ingredients.map {
                .init(
                    imageUrl: $0.thumbnailLink,
                    nameIngredient: $0.ingredient,
                    measure: $0.measure
                )
            } ?? []
            updateMealDetail()
        }
    }
    
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
        fetchMeal()
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
    
    func didSelectSegment(at index: Int) {
        let segment = segmentedItems[index]
        selectSegment(segment)
    }
    
    func didTapOnWatchVideoButton() {
        guard
            let youtubeLink = meal?.youtubeLink,
            let url = URL(string: youtubeLink)
        else { return }
        
        router.openUrl(url)
    }
    
    func didTapOnFavoriteButton() {
        meal?.isFavorite.toggle()
        
        guard let meal = meal else { return }
        meal.isFavorite ? interactor.addFavoriteMeal(meal) : interactor.deleteFavoriteMeal(meal)
        updateFavoriteState()
    }
    
}

// MARK: - MealDetailInteractorOutput

extension MealDetailPresenter: MealDetailInteractorOutput {
    
}

private extension MealDetailPresenter {
    
    func updateMealDetail() {
        guard let meal = meal else { return }
        
        view?.refreshList()
        view?.updateMealName(meal.name)
        view?.updateRecipeText(meal.instructions)
        view?.updateMealImage(imageUrl: meal.thumbnailLink)
        updateFavoriteState()
        
        if let youtubeLink = meal.youtubeLink, !youtubeLink.isEmpty {
            view?.showWatchVideoButton()
        }
    }
    
    func updateFavoriteState() {
        guard let value = meal?.isFavorite else { return }
        value ? view?.applyFavoriteAppearance() : view?.resetFavoriteAppearance()
    }
    
    func selectSegment(_ segment: MealDetailSegment) {
        switch segment {
        case .ingredients:
            view?.showIngredientList()
        case .recipe:
            view?.showRecipeText()
        }
    }
    
    func fetchMeal() {
        view?.showLoader()
        interactor.getMeal { result in
            switch result {
            case .success(let meal):
                self.meal = meal
            case .failure(let error):
                self.router.presentErrorAlert(with: error.description)
            }
            self.view?.hideLoader()
        }
    }
    
}
