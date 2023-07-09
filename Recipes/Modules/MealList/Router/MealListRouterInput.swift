//
//  MealListRouterInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

protocol MealListRouterInput: AnyObject {
    func showMealDetail(mealId: String)
}
