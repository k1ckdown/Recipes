//
//  HomeInteractorInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import Foundation

protocol HomeInteractorInput: AnyObject {
    func getAreaList(completion: @escaping (Result<[Area], NetworkError>) -> Void)
    func getCategories(completion: @escaping (Result<[Category], NetworkError>) -> Void)
    func getMeal(_ type: MealAPI, completion: @escaping (Result<Meal, NetworkError>) -> Void)
    func getPopularMealList(completion: @escaping (Result<[Meal], NetworkError>) -> Void)
    func getLatestMealList(completion: @escaping (Result<[Meal], NetworkError>) -> Void)
}
