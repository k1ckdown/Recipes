//
//  HomeRouterInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import Foundation

protocol HomeRouterInput: AnyObject {
    func showMealDetail(mealId: String)
}
