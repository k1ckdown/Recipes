//
//  MealDetailViewOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Foundation

protocol MealDetailViewOutput: AnyObject {
    var watchVideoTitle: String { get }
    var ingredientCellModels: [IngredientCellModel] { get }
    
    func viewDidLoad()
    func numberOfItems() -> Int
    
    func didTapOnFavoriteButton()
    func didTapOnWatchVideoButton()
    func didSelectSegment(at index: Int)
    
    func getSegmentedItems() -> [String]
    func getStartSelectedSegment() -> Int
}
