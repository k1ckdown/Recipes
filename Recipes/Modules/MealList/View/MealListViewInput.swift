//
//  MealListViewInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

protocol MealListViewInput: AnyObject {
    func refreshList()
    func updateNavigationTitle(_ title: String)
}
