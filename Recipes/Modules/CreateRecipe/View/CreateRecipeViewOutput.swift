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
    
    func viewDidLoad()
    func addIngredientButtonTapped()
    func didEndEditingNameRecipe(_ name: String?)
    func didEndEditingDescRecipe(_ desc: String?)
}
