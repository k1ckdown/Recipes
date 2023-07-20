//
//  SearchRouterInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

protocol SearchRouterInput: AnyObject, AlertPresentable {
    func showMealDetail(mealId: String)
}
