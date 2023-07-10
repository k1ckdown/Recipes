//
//  SearchRouterInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

protocol SearchRouterInput: AnyObject {
    func showMealDetail(mealId: String)
}