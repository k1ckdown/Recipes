//
//  MealLocalDataSourceProtocol.swift
//  Recipes
//
//  Created by Ivan Semenov on 21.07.2023.
//

import Foundation

protocol MealLocalDataSourceProtocol {
    func deleteMeal(_ meal: Meal)
    func saveMeal(_ meal: Meal, uid: String)
    func getMealList(_ uid: String, completion: (Result<[Meal], Error>) -> Void)
}
