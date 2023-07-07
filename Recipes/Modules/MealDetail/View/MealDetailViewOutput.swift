//
//  MealDetailViewOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Foundation

protocol MealDetailViewOutput: AnyObject {
    var ingredientCellModels: [IngredientCellModel] { get }
    
    func viewDidLoad()
    func numberOfItems() -> Int
}
