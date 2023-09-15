//
//  CreateRecipeViewOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.09.2023.
//

import Foundation

protocol CreateRecipeViewOutput: AnyObject {
    var sceneTitle: String { get }

	var nameRecipeTitle: String { get }
	var nameRecipePlaceholder: String { get }

	var descRecipeTitle: String { get }
	var descRecipePlaceholder: String { get }

	var ingredientsTilte: String { get }
	var addIngredientTitle: String { get }

	var ingredientCellModels: [IngredientCellModel] { get }

	func viewDidLoad()
	func numberOfRows() -> Int
	func didTapOnAddIngredientButton()
}
