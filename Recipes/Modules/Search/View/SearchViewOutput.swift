//
//  SearchViewOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

protocol SearchViewOutput: AnyObject {
    var mealCellModels: [MealCellModel] { get }
    
    func viewDidLoad()
    func numberOfItems() -> Int
    func didSelectRow(at indexPath: IndexPath)
}
