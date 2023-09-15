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

	private(set) var ingredientCellModels = [IngredientCellModel]()

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

	func numberOfRows() -> Int {
		ingredientCellModels.count
	}

	func onError(message: String) {
		router.presentErrorAlert(with: message)
	}

	func didRetrieveIngredients(_ ingredients: [MealIngredient]) {
		ingredientCellModels = ingredients.map {
			.init(imageUrl: $0.thumbnailLink,
				  nameIngredient: $0.ingredient,
				  measure: $0.measure
			)
		}
		view?.refreshList(numberOfRows: ingredientCellModels.count)
	}

}

// MARK: - CreateRecipeInteractorOutput

extension CreateRecipePresenter: CreateRecipeInteractorOutput {

	func didTapOnAddIngredientButton() {

	}

}

// MARK: - Private methods

private extension CreateRecipePresenter {

}
