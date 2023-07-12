//
//  FavoritesRouterInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import Foundation

protocol FavoritesRouterInput: AnyObject {
    func showMealDetail(mealId: String)
}
