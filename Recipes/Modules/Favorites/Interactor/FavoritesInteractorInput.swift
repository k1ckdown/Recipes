//
//  FavoritesInteractorInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import Foundation

protocol FavoritesInteractorInput: AnyObject {
    func userIsSignedIn() -> Bool
    func getFavoriteMeals() -> [Meal]
    func deleteFavoriteMeal(_ meal: Meal) 
}
