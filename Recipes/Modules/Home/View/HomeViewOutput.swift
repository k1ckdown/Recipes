//
//  HomeViewOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import Foundation

protocol HomeViewOutput: AnyObject {
    var areaCellModels: [AreaCellModel] { get }
    var latestMealCellModels: [FoodCellModel] { get }
    var randomMealCellModels: [FoodCellModel] { get }
    var ingredientCellModels: [FoodCellModel] { get }
    
    func viewDidLoad()
    func numberOfSections() -> Int
    func section(at index: Int) -> HomeSection
    func numberOfItems(at sectionIndex: Int) -> Int
}
