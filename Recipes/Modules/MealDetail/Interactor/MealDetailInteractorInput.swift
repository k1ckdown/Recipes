//
//  MealDetailInteractorInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Foundation

protocol MealDetailInteractorInput: AnyObject {
    func retrieveMeals()
    func toggleFavoriteMealState()
}
