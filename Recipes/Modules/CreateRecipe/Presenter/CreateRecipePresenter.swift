//
//  CreateRecipePresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.09.2023.
//

import Foundation

final class CreateRecipePresenter {

    private(set) var sceneTitle = "Creating a recipe"

    private(set) var nameRecipeTitle = "Recipe name"
    private(set) var nameRecipePlaceholder = "For example: Caesar salad"

    private(set) var descRecipeTitle = "Recipe description"
    private(set) var descRecipePlaceholder = "Describe the cooking process"

    private(set) var ingredientsTilte = "Ingredients"
    private(set) var addIngredientTitle = "Add Ingredient"

    private var nameRecipe = ""
    private var descRecipe = ""

    private weak var view: CreateRecipeViewInput?
    private let interactor: CreateRecipeInteractorInput
    private let router: CreateRecipeRouterInput

    init(
        view: CreateRecipeViewInput,
        interactor: CreateRecipeInteractorInput,
        router: CreateRecipeRouterInput
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

}

// MARK: - CreateRecipeViewOutput

extension CreateRecipePresenter: CreateRecipeViewOutput {

    func viewDidLoad() {
        interactor.retrieveIngredients()
    }

    func addIngredientButtonTapped() {

    }

    func didEndEditingNameRecipe(_ name: String?) {
        guard let name = name else { return }
        nameRecipe = name
    }

    func didEndEditingDescRecipe(_ desc: String?) {
        guard let desc = desc else { return }
        descRecipe = desc
    }

}

// MARK: - CreateRecipeInteractorOutput

extension CreateRecipePresenter: CreateRecipeInteractorOutput {

    func onError(message: String) {
        router.presentErrorAlert(with: message)
    }

    func didRetrieveIngredients(_ ingredients: [MealIngredient]) {
        let ingredientCellModels = ingredients.map {
            IngredientCellModel(imageUrl: $0.thumbnailLink,
                                nameIngredient: $0.ingredient,
                                measure: $0.measure
            )
        }
        view?.refreshList(items: ingredientCellModels)
    }

}

// MARK: - Private methods

private extension CreateRecipePresenter {

}
