//
//  HomeRouterInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import Foundation

protocol HomeRouterInput: AnyObject, AlertPresentable {
    func showMealDetail(mealId: String)
    func showMealList(mealListType: MealListType)
}
