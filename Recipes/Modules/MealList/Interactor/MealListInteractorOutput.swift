//
//  MealListInteractorOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

protocol MealListInteractorOutput: AnyObject {
    func onError(message: String)
    func didRetrieveMeals(_ meals: [Meal], filterName: String)
}
