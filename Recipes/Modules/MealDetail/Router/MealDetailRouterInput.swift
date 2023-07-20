//
//  MealDetailInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Foundation

protocol MealDetailRouterInput: AnyObject, AlertPresentable {
    func openUrl(_ url: URL)
}
