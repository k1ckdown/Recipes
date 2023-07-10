//
//  SearchInteractorInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

protocol SearchInteractorInput: AnyObject {
    func getRandomMealList(completion: @escaping (Result<[Meal], NetworkError>) -> Void)
    func getMealListByName(_ name: String, completion: @escaping (Result<[Meal], NetworkError>) -> Void)
}
