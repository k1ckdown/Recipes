//
//  HomeInteractorOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import Foundation

protocol HomeInteractorOutput: AnyObject {
    func onError(message: String)
    
    func didRetrieveAreas(_ areas: [Area])
    func didRetrieveLatestMeals(_ meals: [Meal])
    func didRetrievePopularMeals(_ meals: [Meal])
    func didRetrieveCategories(_ categories: [Category])
}
