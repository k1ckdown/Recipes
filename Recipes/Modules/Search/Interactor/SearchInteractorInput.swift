//
//  SearchInteractorInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

protocol SearchInteractorInput: AnyObject {
    func retrieveRandomMeals()
    func retrieveMealListByName(_ name: String)
    
    func getMealId(at index: Int) -> String
}
