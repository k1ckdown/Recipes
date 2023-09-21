//
//  CreateRecipeViewInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.09.2023.
//

import Foundation

protocol CreateRecipeViewInput: AnyObject {
    func refreshList(items: [IngredientCellModel])
}
