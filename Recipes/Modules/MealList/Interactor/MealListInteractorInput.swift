//
//  MealListInteractorInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

protocol MealListInteractorInput: AnyObject {
    func retrieveMeals()
    func getMealId(at index: Int) -> String
}
