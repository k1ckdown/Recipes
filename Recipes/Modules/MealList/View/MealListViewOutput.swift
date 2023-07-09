//
//  MealListViewOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

protocol MealListViewOutput: AnyObject {
    var mealCellModels: [FoodCellModel] { get }
    
    func viewDidLoad()
    func numberOfItems() -> Int
    func didSelectItem(at indexPath: IndexPath)
}
