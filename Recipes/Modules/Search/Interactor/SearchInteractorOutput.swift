//
//  SearchInteractorOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

protocol SearchInteractorOutput: AnyObject {
    func onError(message: String)
    
    func didRetrieveRandomMeals(_ meals: [Meal])
    func didRetrieveMealListByName(_ meals: [Meal])
}
