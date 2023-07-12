//
//  FavoritesViewOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import Foundation

protocol FavoritesViewOutput: AnyObject {
    var mealCellModels: [MealCellModel] { get }
    
    func viewWillAppear()
    func numberOfRows() -> Int
    func introTitle() -> String
    func removeFavoriteMeal(at index: Int)
    func didSelectRow(at indexPath: IndexPath)
}
