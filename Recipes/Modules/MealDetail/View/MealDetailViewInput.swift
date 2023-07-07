//
//  MealDetailViewInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Foundation

protocol MealDetailViewInput: AnyObject {
    func refreshList()
    func updateMealImage(imageUrl: String)
}
