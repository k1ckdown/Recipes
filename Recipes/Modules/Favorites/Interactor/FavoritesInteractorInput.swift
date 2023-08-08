//
//  FavoritesInteractorInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import Foundation

protocol FavoritesInteractorInput: AnyObject {
    func retrieveFavoriteMeals()
    func getMealId(at index: Int) -> String
    func deleteFavoriteMeal(at index: Int)
}
