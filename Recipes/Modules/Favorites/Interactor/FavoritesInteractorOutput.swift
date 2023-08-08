//
//  FavoritesInteractorOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import Foundation

protocol FavoritesInteractorOutput: AnyObject {
    func loginFailure()
    func onError(message: String)
    
    func didRemoveMealFromFavorites(at index: Int)
    func didRetrieveFavoriteMeals(_ meals: [Meal])
}
