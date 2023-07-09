//
//  SearchInteractorInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

protocol SearchInteractorInput: AnyObject {
    func getMealList(completion: @escaping (Result<[Meal], NetworkError>) -> Void)
}
