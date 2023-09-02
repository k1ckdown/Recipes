//
//  MealRemoteDataSourceProtocol.swift
//  Recipes
//
//  Created by Ivan Semenov on 21.07.2023.
//

import Foundation

protocol MealRemoteDataSourceProtocol {
    func saveMeal(_ meal: Meal, uid: String)
    func deleteMeal(_ meal: Meal, uid: String)
    func fetchMeal(_ uid: String, completion: @escaping (Result<[Meal], Error>) -> Void)
}
