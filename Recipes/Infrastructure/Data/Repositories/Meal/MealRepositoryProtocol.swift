//
//  MealRepositoryProtocol.swift
//  Recipes
//
//  Created by Ivan Semenov on 21.07.2023.
//

import Foundation

protocol MealRepositoryProtocol {
    func updateFavoriteMeals()
    func getFavoriteMealList() throws -> [Meal]
    
    func putFavoriteMeal(_ meal: Meal) throws
    func removeFavoriteMeal(_ meal: Meal) throws
    
    func loadAreaList(completion: @escaping (Result<[Area], NetworkError>) -> Void)
    func loadCategoryList(completion: @escaping (Result<[Category], NetworkError>) -> Void)
    func loadIngredientList(completion: @escaping (Result<[Ingredient], NetworkError>) -> Void)
    func loadMealList(_ type: MealAPI, completion: @escaping (Result<[Meal], NetworkError>) -> Void)
    func loadMeal(_ type: MealAPI, completion: @escaping (Result<Meal, NetworkError>) -> Void)
}
