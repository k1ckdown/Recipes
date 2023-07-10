//
//  SearchViewOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

protocol SearchViewOutput: AnyObject {
    var searchPlaceholder: String { get }
    var mealCellModels: [MealCellModel] { get }
    
    func viewDidLoad()
    func numberOfItems() -> Int
    func didPerformSearch(_ value: String?)
    func didSelectRow(at indexPath: IndexPath)
}
