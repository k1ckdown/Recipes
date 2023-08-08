//
//  HomeInteractorInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import Foundation

protocol HomeInteractorInput: AnyObject {
    func retrieveAreaList()
    func retrieveCategories()
    func retrieveLatestMealList()
    func retrievePopularMealList()
    
    func getAreaName(at index: Int) -> String
    func getCategoryName(at index: Int) -> String
    func getLatestMealId(at index: Int) -> String
    func getPopularMealId(at index: Int) -> String
}
