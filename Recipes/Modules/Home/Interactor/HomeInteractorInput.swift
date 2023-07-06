//
//  HomeInteractorInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import Foundation

protocol HomeInteractorInput: AnyObject {
    func getAreaList(completion: @escaping (Result<[Area], NetworkError>) -> Void)
    func getIngredients(completion: @escaping (Result<[Ingredient], NetworkError>) -> Void)
    func getMeal(_ type: MealAPI, completion: @escaping (Result<Meal, NetworkError>) -> Void)
    func getMealList(_ type: MealAPI, completion: @escaping (Result<[Meal], NetworkError>) -> Void)
}
